# Logical Architecture & Integration

Архитектурный раздел описывает единый комплекс АРМ и его внутренние контуры. UMMS (`umms-web`) рассматривается как внешняя система / интеграционный сервис, а «Граждане» — как функциональная область обработки досье физических лиц внутри АРМ.

## Архитектурные схемы

Существующие Mermaid-источники сохранены по прежним путям и подключены ссылками, чтобы не создавать вторые копии диаграмм:

- [Каталог основных архитектурных схем — 10 диаграмм](../materials/architecture/README.md)
- [Компонентные карты — 7 схем и связанные пояснения](../materials/architecture/component-maps.md)
- [Системный контекст и границы — RU](../materials/architecture/system-context-and-scope.ru.md)
- [Системный контекст и границы — EN](../materials/architecture/system-context-and-scope.en.md)
- [Архитектура и исходная реконструкция ОКР](../materials/architecture/deshifrator-14-source-reconstruction.ru.md)

## Обмен и интеграции

- [Обмен данными и администрирование — RU](../materials/architecture/data-exchange-and-administration.ru.md)
- [Обмен данными и администрирование — EN](../materials/architecture/data-exchange-and-administration.en.md)
- [Управление доступом — RU](../materials/architecture/access-control.ru.md)
- [Управление доступом — EN](../materials/architecture/access-control.en.md)
- [Обмен файлами и MRZ](../materials/deshifrator/docs/data-exchange-and-mrz.md)

## Границы и governance

- ПОСС, ПОМС, ПОШ ВБД — внутренние контуры одного АРМ.
- `ModuleStationary` / `ModuleMobile` — имена программных компонентов в исходниках; соответствие внутренним контурам требует подтверждения.
- UMMS / `umms-web` — внешняя система/сервис. Не смешивать с доменом «Граждане».
- Схемы описывают логическую архитектуру; не все связи подтверждены развернутой промышленной топологией.
