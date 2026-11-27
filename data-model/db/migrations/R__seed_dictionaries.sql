-- R__seed_dictionaries.sql: Идемпотентная синхронизация справочников НСИ
INSERT INTO ref_document_type (id, name) VALUES
(1, 'Паспорт гражданина Российской Федерации'),
(2, 'Иностранный паспорт'),
(3, 'Свидетельство о рождении'),
(4, 'Загранпаспорт нового поколения (с биометрией)')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;
SELECT setval(
pg_get_serial_sequence('ref_document_type', 'id'),
GREATEST((SELECT COALESCE(MAX(id), 1) FROM ref_document_type), 1),
true
);
INSERT INTO ref_document_reason (id, name) VALUES
(1, 'Приобретение гражданства Российской Федерации'),
(2, 'Утрата паспорта'),
(3, 'Непригодность к использованию в связи с порчей по вине владельца'),
(4, 'Достижение 45 лет')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;
SELECT setval(
pg_get_serial_sequence('ref_document_reason', 'id'),
GREATEST((SELECT COALESCE(MAX(id), 1) FROM ref_document_reason), 1),
true
);
INSERT INTO ref_department (id, code, name, region_code, region_name) VALUES
(1, '000-001', 'Тестовое подразделение № 1', '00', 'Тестовый регион'),
(2, '000-002', 'Тестовое подразделение № 2', '00', 'Тестовый регион'),
(3, '000-003', 'Тестовое подразделение № 3', '00', 'Тестовый регион'),
(4, '000-004', 'Тестовое подразделение № 4', '00', 'Тестовый регион')
ON CONFLICT (id) DO UPDATE SET
code = EXCLUDED.code,
name = EXCLUDED.name,
region_code = EXCLUDED.region_code,
region_name = EXCLUDED.region_name;
SELECT setval(
pg_get_serial_sequence('ref_department', 'id'),
GREATEST((SELECT COALESCE(MAX(id), 1) FROM ref_department), 1),
true
);
INSERT INTO gateway_dictionary_version (dict_code, version_number) VALUES
('DOC_TYPES', 1),
('DOC_REASONS', 1),
('DEPARTMENTS', 1)
ON CONFLICT (dict_code) DO UPDATE SET
version_number = EXCLUDED.version_number,
updated_at = NOW();
