-- V001: Базовые таблицы и первичные ключи (24 таблицы)

CREATE TABLE ref_document_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE ref_document_reason (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE ref_department (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) NOT NULL,
    name VARCHAR(500) NOT NULL,
    region_code VARCHAR(10),
    region_name VARCHAR(255)
);

CREATE TABLE person (
    id BIGSERIAL PRIMARY KEY,
    external_ir_id BIGINT,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    gender CHAR(1),
    birth_date DATE NOT NULL,
    death_date DATE,
    birth_country VARCHAR(100),
    birth_place VARCHAR(500),
    citizenship VARCHAR(100),
    inn VARCHAR(12),
    military_duty_info VARCHAR(255),
    is_hidden BOOLEAN DEFAULT FALSE,
    vbd_export_date TIMESTAMP,
    need_external_sync BOOLEAN DEFAULT FALSE
);

CREATE TABLE document (
    id BIGSERIAL PRIMARY KEY,
    person_id BIGINT NOT NULL,
    doc_type_id INT NOT NULL,
    series VARCHAR(20),
    number VARCHAR(30) NOT NULL,
    issue_date DATE,
    actual_issue_date DATE,
    valid_from DATE,
    valid_to DATE,
    department_id INT,
    dept_code VARCHAR(20),
    issued_by_full VARCHAR(500),
    application_place VARCHAR(500),
    reason_id INT,
    status VARCHAR(50) NOT NULL,
    is_first_doc BOOLEAN DEFAULT FALSE,
    has_mrz BOOLEAN DEFAULT FALSE,
    mrz_line_1 VARCHAR(44),
    mrz_line_2 VARCHAR(44),
    executor_name VARCHAR(255),
    extra_attributes JSONB
);

CREATE TABLE document_operation (
    id BIGSERIAL PRIMARY KEY,
    document_id BIGINT NOT NULL,
    operation_date DATE NOT NULL,
    operation_name VARCHAR(500) NOT NULL
);

CREATE TABLE person_relation (
    id BIGSERIAL PRIMARY KEY,
    person_id BIGINT NOT NULL,
    relation_type VARCHAR(50) NOT NULL,
    related_fio VARCHAR(300) NOT NULL,
    related_gender CHAR(1),
    related_birth_date DATE,
    act_number VARCHAR(50),
    issued_by VARCHAR(500),
    date_from DATE,
    date_to DATE
);

CREATE TABLE address_registration (
    id BIGSERIAL PRIMARY KEY,
    person_id BIGINT NOT NULL,
    reg_type VARCHAR(100) NOT NULL,
    date_from DATE,
    date_to DATE,
    country VARCHAR(100),
    region VARCHAR(255),
    district VARCHAR(255),
    city VARCHAR(255),
    street VARCHAR(255),
    house VARCHAR(20),
    building VARCHAR(20),
    flat VARCHAR(20),
    full_address VARCHAR(1000) NOT NULL,
    fias_guid UUID,
    case_extra_attributes JSONB
);

CREATE TABLE dossier_case (
    id BIGSERIAL PRIMARY KEY,
    person_id BIGINT NOT NULL,
    case_number VARCHAR(100) NOT NULL,
    open_date DATE,
    close_date DATE,
    status VARCHAR(50) NOT NULL,
    status_date DATE,
    case_type VARCHAR(500) NOT NULL,
    is_applicant BOOLEAN DEFAULT TRUE,
    applicant_fio VARCHAR(300),
    applicant_doc_info VARCHAR(255),
    person_role VARCHAR(100)
);

CREATE TABLE dossier_signal (
    id BIGSERIAL PRIMARY KEY,
    person_id BIGINT NOT NULL,
    entity_type VARCHAR(20) NOT NULL,
    entity_id BIGINT NOT NULL,
    period_from DATE,
    period_to DATE,
    signal_type VARCHAR(100),
    message VARCHAR(500),
    content TEXT
);

CREATE TABLE passport_stamp_registration (
    id BIGSERIAL PRIMARY KEY,
    document_id BIGINT NOT NULL,
    page_number INT NOT NULL,
    orientation VARCHAR(10) NOT NULL,
    form_code VARCHAR(10) NOT NULL,
    stamp_date DATE NOT NULL,
    addr_country VARCHAR(100),
    addr_region VARCHAR(255),
    addr_district VARCHAR(255),
    addr_city VARCHAR(255),
    addr_street VARCHAR(255),
    addr_house VARCHAR(20),
    addr_building VARCHAR(20),
    addr_flat VARCHAR(20),
    fias_guid UUID,
    department_name VARCHAR(500) NOT NULL,
    dept_code VARCHAR(20) NOT NULL
);

CREATE TABLE passport_stamp_military (
    id BIGSERIAL PRIMARY KEY,
    document_id BIGINT NOT NULL,
    page_number INT NOT NULL DEFAULT 13,
    form_code VARCHAR(10) NOT NULL DEFAULT '11П',
    stamp_date DATE NOT NULL,
    dept_code VARCHAR(20) NOT NULL
);

CREATE TABLE passport_stamp_marriage (
    id BIGSERIAL PRIMARY KEY,
    document_id BIGINT NOT NULL,
    page_number INT NOT NULL,
    orientation VARCHAR(10) NOT NULL,
    form_code VARCHAR(10) NOT NULL,
    event_date DATE NOT NULL,
    termination_date DATE,
    spouse_fio VARCHAR(300) NOT NULL,
    spouse_birth_date DATE,
    zags_name VARCHAR(500) NOT NULL,
    act_number VARCHAR(50) NOT NULL,
    dept_code VARCHAR(20) NOT NULL
);

CREATE TABLE passport_stamp_children (
    id BIGSERIAL PRIMARY KEY,
    document_id BIGINT NOT NULL,
    page_number INT NOT NULL DEFAULT 17,
    child_fio VARCHAR(300) NOT NULL,
    child_gender CHAR(1) NOT NULL,
    child_birth_date DATE NOT NULL
);

CREATE TABLE passport_stamp_prev_docs (
    id BIGSERIAL PRIMARY KEY,
    document_id BIGINT NOT NULL,
    page_number INT NOT NULL DEFAULT 19,
    form_code VARCHAR(10) NOT NULL DEFAULT '16П',
    prev_doc_series VARCHAR(20) NOT NULL,
    prev_doc_number VARCHAR(30) NOT NULL,
    dept_code VARCHAR(20) NOT NULL,
    issue_date DATE NOT NULL
);

CREATE TABLE print_page_state (
    id BIGSERIAL PRIMARY KEY,
    document_id BIGINT NOT NULL,
    page_number INT NOT NULL,
    print_count INT NOT NULL DEFAULT 0,
    is_fixed BOOLEAN NOT NULL DEFAULT FALSE,
    fixed_at TIMESTAMP,
    layout_snapshot JSONB
);

CREATE TABLE used_blank_journal (
    id BIGSERIAL PRIMARY KEY,
    document_id BIGINT,
    person_id BIGINT,
    blank_series VARCHAR(4) NOT NULL,
    blank_number VARCHAR(6) NOT NULL,
    printed_at TIMESTAMP NOT NULL DEFAULT NOW(),
    operator_login VARCHAR(100) NOT NULL,
    is_spoiled BOOLEAN DEFAULT FALSE,
    comment TEXT
);

CREATE TABLE export_batch (
    id BIGSERIAL PRIMARY KEY,
    task_number VARCHAR(50) NOT NULL,
    approval_date TIMESTAMP NOT NULL,
    comment TEXT NOT NULL,
    export_date TIMESTAMP,
    import_date TIMESTAMP,
    processing_stage INT DEFAULT 1
);

CREATE TABLE export_batch_person (
    batch_id BIGINT NOT NULL,
    person_id BIGINT NOT NULL,
    PRIMARY KEY (batch_id, person_id)
);

CREATE TABLE edit_scenario_log (
    id BIGSERIAL PRIMARY KEY,
    person_id BIGINT NOT NULL,
    scenario_code VARCHAR(20) NOT NULL,
    status VARCHAR(255) NOT NULL,
    is_cancelled BOOLEAN DEFAULT FALSE,
    is_exported_to_vbd BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    user_login VARCHAR(100) NOT NULL
);

CREATE TABLE audit_log (
    id BIGSERIAL PRIMARY KEY,
    event_time TIMESTAMP DEFAULT NOW(),
    user_login VARCHAR(100) NOT NULL,
    action_type VARCHAR(100) NOT NULL,
    details JSONB
);

CREATE TABLE vbd_dossier_snapshot (
    id BIGSERIAL PRIMARY KEY,
    person_id BIGINT NOT NULL,
    external_ir_id BIGINT NOT NULL,
    vbd_row_version VARCHAR(64) NOT NULL,
    snapshot_payload JSONB NOT NULL,
    loaded_at TIMESTAMP NOT NULL DEFAULT NOW(),
    expires_at TIMESTAMP NOT NULL,
    is_reverted BOOLEAN DEFAULT FALSE,
    reverted_at TIMESTAMP
);

CREATE TABLE gateway_connection_log (
    id BIGSERIAL PRIMARY KEY,
    connected_at TIMESTAMP NOT NULL DEFAULT NOW(),
    mm_client_ip INET NOT NULL,
    mm_login VARCHAR(100) NOT NULL,
    is_auth_success BOOLEAN NOT NULL,
    operation_type VARCHAR(50) NOT NULL,
    records_count INT DEFAULT 0,
    error_message TEXT
);

CREATE TABLE gateway_dictionary_version (
    dict_code VARCHAR(50) PRIMARY KEY,
    version_number INT NOT NULL DEFAULT 1,
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);
