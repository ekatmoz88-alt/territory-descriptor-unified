# АРМ обработки досье / АРМ обработки досье — Technical Documentation

[![CI](https://github.com/ekatmoz88-alt/territory-descriptor-unified/actions/workflows/ci.yml/badge.svg)](https://github.com/ekatmoz88-alt/territory-descriptor-unified/actions/workflows/ci.yml)

## Идентификация комплекса

| Наименование | Значение |
|---|---|
| АРМ обработки досье | Основное/историческое обозначение программного комплекса |
| АРМ обработки досье | Наименование рабочего места в проектных материалах |
| проектное обозначение не публикуется | Наименование опытно-конструкторской работы |
| Case Processing Workstation | Англоязычное обозначение того же АРМ |

Это один программный комплекс (АРМ), а не четыре самостоятельных продукта. ПОСС, ПОМС и ПОШ ВБД — внутренние контуры комплекса. «Граждане» — функциональная область внутри АРМ. внешний SOAP-сервис — внешняя интеграционная система/сервис.

## Пять представлений документации

1. [As-Specified — требования и спецификации](specs/README.md)
2. [Logical Architecture & Integration](architecture/README.md)
3. [As-Built — Reverse Engineering](as-built/README.md)
4. [Verification — испытания и дефекты](verification/README.md)
5. [Data Model — реконструированная модель и миграции](data-model/README.md)

## Governance disclaimers

- PostgreSQL-схема на 24 таблицы — `Reconstructed Logical Data Model (PostgreSQL)`, не физическая схема промышленной Oracle/SQLite-БД.
- Flyway / PostgreSQL 16: `Prepared / Pending CI verification`; успешный прогон не подтверждён приложенным логом.
- Проверка дистрибутива Discriptor выявила блокер запуска из-за отсутствующих бинарных модулей/архива зависимостей; это не успешная установка всей системы.
- Сопоставление ПОСС/ПОМС/ПОШ ВБД с `ModuleStationary`/`ModuleMobile` требует отдельной проверки.

## Документация и исходные доказательства

Содержимое перенесено в пять канонических разделов без дублирования. Старые HTML/Markdown entrypoints сохранены как redirect/compatibility pages, а прежние Docsify-маршруты перенаправляются через `window.$docsify.alias`. Подробные доказательства и ограничения см. в соответствующих пяти разделах.
