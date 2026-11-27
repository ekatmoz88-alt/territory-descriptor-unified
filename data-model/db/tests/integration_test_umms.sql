(Тестовый пакет из test_queries_umms_discriptor-v3.sql, очищенный от дублирования справочников (их теперь накатывает R__seed_dictionaries.sql), плюс объединены все негативные тесты ФЛК из SQL и из run_tests-v6.sh — включая проверку passport_stamp_military на страницу 99).
sql
-- ============================================================================
-- ИНТЕГРАЦИОННЫЕ ТЕСТЫ БД ПРОЕКТА «ДЕШИФРАТОР» (Flyway-совместимая версия)
-- Справочники НСИ предзагружены повторяемой миграцией R__seed_dictionaries.sql
-- ============================================================================

-- ============================================================================
-- БЛОК 1. НАПОЛНЕНИЕ 4 КОНТРОЛЬНЫХ ДОСЬЕ ИЗ ПРОТОКОЛА
-- (Иванов Г.Л., Петров Э.А., Сидоров Э.Г., Кузнецов В.В.)
-- ============================================================================

-- Досье №1: Иванов Иван Иванович
INSERT INTO person (id, external_ir_id, last_name, first_name, middle_name, gender, birth_date, birth_country, birth_place, citizenship, is_hidden, vbd_export_date, need_external_sync)
VALUES (1, 100001, 'Иванов', 'Геннадий', 'Леонидович', 'M', '1984-02-03', 'СССР', 'Россия, г. Москва', 'Россия', FALSE, '2014-11-11 10:00:00', FALSE);

INSERT INTO document (id, person_id, doc_type_id, series, number, issue_date, actual_issue_date, valid_from, department_id, dept_code, issued_by_full, application_place, reason_id, status, is_first_doc, has_mrz, mrz_line_1, mrz_line_2, executor_name)
VALUES
(101, 1, 2, '9999', '123456', '2005-09-16', '2005-09-16', '2005-09-16', NULL, NULL, 'Тестовое подразделение № 1', 'Тестовое подразделение № 1', NULL, 'Недействительный', FALSE, FALSE, NULL, NULL, 'system'),
(102, 1, 1, '9999', '123456', '2013-04-10', '2013-04-12', '2013-04-12', 1, '000-001', 'Тестовое подразделение № 2', 'Тестовое подразделение № 2', 1, 'Действительный', TRUE, TRUE, 'P<RUSPETROVA<<MARIA<SERGEEVNA<<<<<<<<<<<<<<<', '3410628674RUS8402035M<<<<<<<413041044001', 'system');

INSERT INTO document_operation (document_id, operation_date, operation_name) VALUES
(102, '2013-04-10', 'Подача заявления и принятие решения'),
(102, '2013-04-10', 'Печать и перевод на готовность'),
(102, '2013-04-12', 'Фактическая выдача паспорта гражданину');

INSERT INTO person_relation (person_id, relation_type, related_fio, related_gender, related_birth_date, act_number, issued_by, date_from) VALUES
(1, 'Ребёнок', 'Иванов Пётр Иванович', 'M', '2006-04-14', NULL, NULL, '2006-04-14'),
(1, 'Ребёнок', 'Иванов Алексей Иванович', 'M', '2007-10-19', NULL, NULL, '2007-10-19'),
(1, 'Супруг(а)', 'Петрова Мария Сергеевна', 'F', '1976-05-12', '102', 'Тестовый орган ЗАГС', '2011-03-09');

INSERT INTO address_registration (person_id, reg_type, date_from, date_to, country, region, district, city, house, full_address) VALUES
(1, 'По месту жительства', '2013-04-12', NULL, 'Россия', 'г. Москва', 'Центральный район', 'г. Москва', '13', 'Россия, г. Москва, Центральный район, г. Москва, д. 13');

INSERT INTO dossier_case (person_id, case_number, open_date, close_date, status, status_date, case_type, is_applicant, applicant_fio, person_role) VALUES
(1, '000-00000000000001', '2013-04-10', '2013-04-12', 'Закрыто', '2013-04-12', 'Выдача/замена паспорта гражданина РФ', TRUE, 'Иванов Иван Иванович', 'Заявитель');

-- Досье №2: Петров Сергей Александрович (сценарий №2 + откат п. 2.4.3 ТЗ)
INSERT INTO person (id, external_ir_id, last_name, first_name, middle_name, gender, birth_date, birth_country, birth_place, citizenship, inn, military_duty_info, is_hidden, vbd_export_date, need_external_sync)
VALUES (2, 100002, 'Петров', 'Эдуард', 'Александрович', 'M', '1973-12-07', 'СССР', 'Россия, г. Москва', 'Россия', '000000000000', 'Военнообязанный', FALSE, '2014-11-19 15:05:00', TRUE);

INSERT INTO document (id, person_id, doc_type_id, series, number, issue_date, actual_issue_date, valid_from, valid_to, department_id, dept_code, issued_by_full, application_place, reason_id, status, is_first_doc, has_mrz, mrz_line_1, mrz_line_2, executor_name)
VALUES
(201, 2, 1, '9999', '123456', '2003-09-16', '2003-09-16', '2003-09-16', '2013-06-27', 2, '000-002', 'Тестовое подразделение № 3', 'Тестовое подразделение № 3', NULL, 'Утерян', TRUE, FALSE, NULL, NULL, 'system'),
(202, 2, 1, '9999', '123456', '2013-06-27', '2013-07-01', '2013-07-01', '2014-11-19', 2, '000-003', 'Тестовое подразделение № 3', 'Тестовое подразделение № 3', 2, 'Недействительный', FALSE, TRUE, 'P<RUSPETROVA<<MARIA<SERGEEVNA<<<<<<<<<<<<<<<', '3410942652RUS7312070M<<<<<<<313062744002', 'system'),
(203, 2, 1, '9999', '123456', '2014-11-19', '2014-11-19', '2014-11-19', NULL, 3, '000-005', 'Тестовое подразделение № 4', 'Тестовое подразделение № 4', 3, 'Действительный', FALSE, TRUE, 'P<RUSPETROVA<<MARIA<SERGEEVNA<<<<<<<<<<<<<<<', '4004837780RUS7312070M<<<<<<<814111977002', 'admin');

INSERT INTO address_registration (person_id, reg_type, date_from, date_to, country, region, city, street, house, flat, full_address) VALUES
(2, 'По месту жительства', '1992-12-02', '2013-11-11', 'Россия', 'г. Москва', 'г. Москва', 'ул. Тестовая', '1/28', '47', '156901 Россия, г. Москва, г. Москва, ул. Тестовая, дом 1/28, кв. 47'),
(2, 'По месту жительства', '1992-12-02', '2013-11-11', 'Россия', 'г. Москва', 'г. Москва', 'ул. Тестовая', '1/28', '47', '156901 Россия, г. Москва, г. Москва, ул. Тестовая, дом 1/28, кв. 47');

INSERT INTO dossier_signal (person_id, entity_type, entity_id, period_from, signal_type, message, content) VALUES
(2, 'DOCUMENT', 201, '2013-06-27', 'Утрата документа', 'Паспорт 3403 595440 числится утраченным', 'Заявление об утрате паспорта от 27.06.2013');

-- Досье №3: Сидоров Алексей Петрович
INSERT INTO person (id, external_ir_id, last_name, first_name, middle_name, gender, birth_date, birth_country, birth_place, citizenship, inn, is_hidden, vbd_export_date, need_external_sync)
VALUES (3, 100003, 'Сидоров', 'Эрик', 'Глебович', 'M', '1980-11-13', 'Россия', 'Россия, г. Москва', 'Россия', '000000000000', FALSE, '2014-11-19 16:37:00', FALSE);

INSERT INTO document (id, person_id, doc_type_id, series, number, issue_date, actual_issue_date, valid_from, valid_to, department_id, dept_code, issued_by_full, application_place, reason_id, status, is_first_doc, has_mrz, executor_name)
VALUES
(301, 3, 1, '9999', '123456', '2012-11-19', '2012-11-19', '2012-11-19', '2014-11-19', 4, '000-004', 'Тестовое подразделение № 4', 'По месту жительства', NULL, 'Недействительный', TRUE, TRUE, 'system system system'),
(302, 3, 1, '9999', '123456', '2014-11-19', '2014-11-19', '2014-11-19', NULL, 3, '000-005', 'Тестовое подразделение № 4', 'По месту жительства', 3, 'Действительный', FALSE, TRUE, 'system system system');

INSERT INTO address_registration (person_id, reg_type, date_from, country, region, city, street, house, flat, full_address) VALUES
(3, 'По месту жительства', '2014-11-18', 'Россия', 'г. Москва', 'г. Москва', 'ул. Тестовая', '123', '2', '403531 Россия, г. Москва, г. Москва, ул. Тестовая, дом 123, кв. 2');

-- Досье №4: Кузнецов Павел Андреевич
INSERT INTO person (id, external_ir_id, last_name, first_name, middle_name, gender, birth_date, birth_country, birth_place, citizenship, is_hidden, vbd_export_date, need_external_sync)
VALUES (4, 100004, 'Кузнецов', 'Валерий', 'Владимирович', 'M', '1968-03-06', 'СССР', 'Россия, г. Москва', 'Россия', FALSE, '2014-11-19 17:21:00', FALSE);

INSERT INTO document (id, person_id, doc_type_id, series, number, issue_date, actual_issue_date, valid_from, department_id, dept_code, issued_by_full, reason_id, status, is_first_doc, has_mrz, executor_name)
VALUES
(401, 4, 1, '9999', '123456', '2002-07-04', '2002-07-04', '2002-07-04', 2, '000-003', 'Тестовое подразделение № 3', NULL, 'Недействительный', TRUE, FALSE, 'system'),
(402, 4, 1, '9999', '123456', '2013-05-27', '2013-06-11', '2013-06-11', 2, '000-003', 'Тестовое подразделение № 3', 4, 'Действительный', FALSE, TRUE, 'system');

SELECT setval('person_id_seq', 4, true);
SELECT setval('document_id_seq', 402, true);

-- Штампы страниц 5–19 паспорта РФ
INSERT INTO passport_stamp_registration (document_id, page_number, orientation, form_code, stamp_date, addr_country, addr_region, addr_city, addr_street, addr_house, addr_flat, department_name, dept_code)
VALUES (202, 5, 'LEFT', '5П', '2013-07-01', 'Россия', 'г. Москва', 'г. Москва', 'ул. Тестовая', '1/28', '47', 'Тестовое подразделение № 3', '000-003');

INSERT INTO passport_stamp_military (document_id, page_number, form_code, stamp_date, dept_code)
VALUES (202, 13, '11П', '2013-07-01', '000-003');

INSERT INTO passport_stamp_marriage (document_id, page_number, orientation, form_code, event_date, spouse_fio, spouse_birth_date, zags_name, act_number, dept_code)
VALUES (202, 14, 'LEFT', '13П', '2012-02-25', 'Сидорова Анна Викторовна', '1967-05-26', 'Тестовый орган ЗАГС', '28', '000-003');

INSERT INTO passport_stamp_children (document_id, page_number, child_fio, child_gender, child_birth_date)
VALUES (202, 17, 'Петров Иван Сергеевич', 'M', '2003-07-22');

INSERT INTO passport_stamp_prev_docs (document_id, page_number, form_code, prev_doc_series, prev_doc_number, dept_code, issue_date)
VALUES (202, 19, '16П', '9999', '123456', '000-002', '2003-09-16');

-- Состояние печати страниц и журнал израсходованных бланков
INSERT INTO print_page_state (document_id, page_number, print_count, is_fixed, fixed_at) VALUES
(202, 2, 1, TRUE, '2013-07-01 12:00:00'),
(202, 3, 2, FALSE, NULL);

INSERT INTO used_blank_journal (document_id, person_id, blank_series, blank_number, operator_login, is_spoiled, comment) VALUES
(202, 2, '9999', '123456', 'admin', FALSE, 'Успешная печать бланка паспорта РФ'),
(302, 3, '9999', '123456', 'admin', FALSE, 'Печать бланка по Сценарию №3');
