# PostgreSQL 16 / Flyway 10 — prepared test bundle

Состав:
- `migrations/V001__init_tables.sql`
- `migrations/V002__constraints_and_fk.sql`
- `migrations/R__seed_dictionaries.sql`
- `tests/integration_test_umms.sql`
- `scripts/run_tests_ci.sh`
- `flyway.conf`

**Статус:** `Prepared / Pending CI verification`. Отсутствие лога не заменяется фиктивной записью. Перед запуском требуются PostgreSQL 16, Flyway 10, роли БД и переменные окружения, перечисленные в скрипте.
