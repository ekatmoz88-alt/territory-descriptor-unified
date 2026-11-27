#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
LOG_DIR="${PROJECT_ROOT}/logs"
mkdir -p "${LOG_DIR}"
LOG_FILE="${LOG_DIR}/ci_run_$(date +%Y%m%d_%H%M%S).log"

export PGHOST="${PGHOST:-localhost}"
export PGPORT="${PGPORT:-5432}"
export PGUSER="${PGUSER:-umms_user}"
export PGADMIN_USER="${PGADMIN_USER:-postgres}"
export PGCONNECT_TIMEOUT="${PGCONNECT_TIMEOUT:-5}"
EXPECTED_TABLES="${EXPECTED_TABLES:-24}"
: "${PGPASSWORD:?Set PGPASSWORD for the application role}"
: "${PGADMIN_PASSWORD:?Set PGADMIN_PASSWORD for the administrator role}"

RAW_SUFFIX="${CI_JOB_ID:-$(date +%s)$$}"
SAFE_SUFFIX="$(printf '%s' "${RAW_SUFFIX}" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9')"
export PGDATABASE="$(printf 'umms_ci_%s' "${SAFE_SUFFIX}" | cut -c 1-63)"
DB_CREATED=0

log() {
  local msg="[$(date '+%Y-%m-%d %H:%M:%S')] $*"
  printf '%s\n' "${msg}" | tee -a "${LOG_FILE}"
}

on_error() {
  local exit_code=$?
  local line_no=$1
  trap - ERR
  log "ERROR: line ${line_no}, exit ${exit_code}: ${BASH_COMMAND}"
  exit "${exit_code}"
}
trap 'on_error $LINENO' ERR

run_admin_psql() {
  PGPASSWORD="${PGADMIN_PASSWORD}" psql -w -h "${PGHOST}" -p "${PGPORT}" -U "${PGADMIN_USER}" -d postgres -v ON_ERROR_STOP=1 "$@"
}
run_user_psql() {
  PGPASSWORD="${PGPASSWORD}" psql -w -h "${PGHOST}" -p "${PGPORT}" -U "${PGUSER}" -d "${PGDATABASE}" -v ON_ERROR_STOP=1 "$@"
}
cleanup() {
  local rc=$?
  trap - EXIT ERR
  if [[ "${DB_CREATED}" -eq 1 ]]; then
    log "Cleanup: dropping temporary database ${PGDATABASE}"
    run_admin_psql -v db_name="${PGDATABASE}" <<'SQL' >/dev/null 2>&1 || true
DROP DATABASE IF EXISTS :"db_name" WITH (FORCE);
SQL
  fi
  exit "$rc"
}
trap cleanup EXIT

log "1. Waiting for PostgreSQL at ${PGHOST}:${PGPORT}"
for attempt in {1..15}; do
  if pg_isready -h "${PGHOST}" -p "${PGPORT}" >/dev/null 2>&1; then
    break
  fi
  if [[ "$attempt" -eq 15 ]]; then
    log "ERROR: PostgreSQL readiness timeout"
    exit 2
  fi
  sleep 1
done

log "2. Checking administrator privileges"
CAN_CREATE_DB="$(PGPASSWORD="${PGADMIN_PASSWORD}" psql -w -h "${PGHOST}" -p "${PGPORT}" -U "${PGADMIN_USER}" -d postgres -tA -v ON_ERROR_STOP=1 -c "SELECT (rolcreatedb OR rolsuper)::text FROM pg_roles WHERE rolname = current_user;")"
if [[ "${CAN_CREATE_DB}" != "true" ]]; then
  log "ERROR: administrator role requires CREATEDB or SUPERUSER"
  exit 4
fi

log "3. Creating temporary database ${PGDATABASE}"
run_admin_psql -v db_name="${PGDATABASE}" -v app_user="${PGUSER}" <<'SQL'
CREATE DATABASE :"db_name" OWNER :"app_user";
SQL
DB_CREATED=1

log "4. Applying Flyway migrations"
export FLYWAY_URL="jdbc:postgresql://${PGHOST}:${PGPORT}/${PGDATABASE}"
export FLYWAY_USER="${PGUSER}"
export FLYWAY_PASSWORD="${PGPASSWORD}"
export FLYWAY_LOCATIONS="filesystem:${PROJECT_ROOT}/migrations"
flyway -configFiles="${PROJECT_ROOT}/flyway.conf" -url="${FLYWAY_URL}" -user="${FLYWAY_USER}" -password="${FLYWAY_PASSWORD}" -locations="${FLYWAY_LOCATIONS}" migrate 2>&1 | tee -a "${LOG_FILE}"

log "5. Verifying application table count"
ACTUAL_TABLES="$(run_user_psql -tA -c "SELECT count(*) FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE' AND table_name <> 'flyway_schema_history';")"
if [[ "${ACTUAL_TABLES}" -ne "${EXPECTED_TABLES}" ]]; then
  log "ERROR: expected ${EXPECTED_TABLES} application tables, found ${ACTUAL_TABLES}"
  exit 3
fi
log "OK: ${ACTUAL_TABLES}/${EXPECTED_TABLES} application tables"

log "6. Running integration SQL tests"
run_user_psql -f "${PROJECT_ROOT}/tests/integration_test_umms.sql" 2>&1 | tee -a "${LOG_FILE}"
log "OK: migrations and integration SQL tests completed"
