-- V002: Внешние ключи (FK), уникальные ключи (UNIQUE) и ограничения ФЛК (CHECK)

ALTER TABLE person
    ADD CONSTRAINT person_gender_check CHECK (gender IN ('M', 'F'));

ALTER TABLE document
    ADD CONSTRAINT document_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE,
    ADD CONSTRAINT document_doc_type_id_fkey FOREIGN KEY (doc_type_id) REFERENCES ref_document_type(id),
    ADD CONSTRAINT document_department_id_fkey FOREIGN KEY (department_id) REFERENCES ref_department(id),
    ADD CONSTRAINT document_reason_id_fkey FOREIGN KEY (reason_id) REFERENCES ref_document_reason(id),
    ADD CONSTRAINT chk_mrz_date CHECK (NOT (has_mrz AND issue_date < DATE '2011-07-01'));

ALTER TABLE document_operation
    ADD CONSTRAINT document_operation_document_id_fkey FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE;

ALTER TABLE person_relation
    ADD CONSTRAINT person_relation_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE,
    ADD CONSTRAINT person_relation_related_gender_check CHECK (related_gender IN ('M', 'F'));

ALTER TABLE address_registration
    ADD CONSTRAINT address_registration_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE;

ALTER TABLE dossier_case
    ADD CONSTRAINT dossier_case_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE;

ALTER TABLE dossier_signal
    ADD CONSTRAINT dossier_signal_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE;

ALTER TABLE passport_stamp_registration
    ADD CONSTRAINT passport_stamp_registration_document_id_fkey FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
    ADD CONSTRAINT passport_stamp_registration_page_number_check CHECK (page_number BETWEEN 5 AND 12),
    ADD CONSTRAINT passport_stamp_registration_orientation_check CHECK (orientation IN ('LEFT', 'RIGHT')),
    ADD CONSTRAINT passport_stamp_registration_form_code_check CHECK (form_code IN ('5П', '7П', '9П'));

Используйте код с осторожностью.
ALTER TABLE passport_stamp_military
ADD CONSTRAINT passport_stamp_military_document_id_fkey FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
ADD CONSTRAINT passport_stamp_military_page_number_check CHECK (page_number = 13);
ALTER TABLE passport_stamp_marriage
ADD CONSTRAINT passport_stamp_marriage_document_id_fkey FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
ADD CONSTRAINT passport_stamp_marriage_page_number_check CHECK (page_number IN (14, 15)),
ADD CONSTRAINT passport_stamp_marriage_orientation_check CHECK (orientation IN ('LEFT', 'RIGHT')),
ADD CONSTRAINT passport_stamp_marriage_form_code_check CHECK (form_code IN ('13П', '15П'));
ALTER TABLE passport_stamp_children
ADD CONSTRAINT passport_stamp_children_document_id_fkey FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
ADD CONSTRAINT passport_stamp_children_page_number_check CHECK (page_number = 17),
ADD CONSTRAINT passport_stamp_children_child_gender_check CHECK (child_gender IN ('M', 'F'));
ALTER TABLE passport_stamp_prev_docs
ADD CONSTRAINT passport_stamp_prev_docs_document_id_fkey FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
ADD CONSTRAINT passport_stamp_prev_docs_page_number_check CHECK (page_number = 19);
ALTER TABLE print_page_state
ADD CONSTRAINT print_page_state_document_id_fkey FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE CASCADE,
ADD CONSTRAINT print_page_state_page_number_check CHECK (page_number BETWEEN 2 AND 19),
ADD CONSTRAINT print_page_state_document_id_page_number_key UNIQUE (document_id, page_number);
ALTER TABLE used_blank_journal
ADD CONSTRAINT used_blank_journal_document_id_fkey FOREIGN KEY (document_id) REFERENCES document(id) ON DELETE SET NULL,
ADD CONSTRAINT used_blank_journal_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE SET NULL,
ADD CONSTRAINT used_blank_journal_blank_series_check CHECK (blank_series ~ '^[0-9]{4}$'),
ADD CONSTRAINT used_blank_journal_blank_number_check CHECK (blank_number ~ '^[0-9]{6}$'),
ADD CONSTRAINT used_blank_journal_blank_series_blank_number_key UNIQUE (blank_series, blank_number);
ALTER TABLE export_batch_person
ADD CONSTRAINT export_batch_person_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES export_batch(id) ON DELETE CASCADE,
ADD CONSTRAINT export_batch_person_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE;
ALTER TABLE edit_scenario_log
ADD CONSTRAINT edit_scenario_log_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id);
ALTER TABLE vbd_dossier_snapshot
ADD CONSTRAINT vbd_dossier_snapshot_person_id_fkey FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE;
