# ППО «Территория» и АРМ «Дискриптор»

Единый публичный архив технической документации, архитектурных обзоров и ограниченных исходных фрагментов по связанным предметным областям и программным компонентам.



## Architecture diagrams

- [Architecture catalogue](materials/architecture/README.md) — system boundaries, modules, data model, deployment and integrations.
- [Detailed component maps](materials/architecture/component-maps.md) — ARM Descriptor, PPO Territory projects, Deshifrator libraries and UMMS workflows.

## Разделы

| Раздел | Содержание |
|---|---|
| [ППО «Территория»](materials/territory/README.md) | Назначение системы, функциональные модули, развёртывание, интеграции, требования и жизненный цикл |
| [База данных и API](materials/territory-database/README.md) | Oracle, логическая и физическая структура, API и модели исходного кода |
| [АРМ «Дискриптор»](materials/descriptor/README.md) | Архитектура мобильной и стационарной станций, обмен данными, оборудование и границы доверия |
| [Программные компоненты](materials/deshifrator/README.md) | ModuleMobile, ModuleStationary, PassportPaint, зависимости, локальное хранение, обмен и доступные фрагменты C# |
| [UMMS / SOAP](materials/umms/README.md) | Публичные материалы по SOAP API, клиенту, локальному хранению досье и интеграции |

## Важное замечание о границах системы

Материалы собраны в одном репозитории для удобства навигации и целостного представления документации. Сам факт объединения файлов **не означает**, что все описанные компоненты являются одним исполняемым продуктом или что все архитектурные связи окончательно подтверждены.

В частности, соответствие обозначений ПОМС / ПОСС обозначениям ModuleMobile / ModuleStationary требует дальнейшей сверки с первичными материалами и исходным кодом. В документах отмечаются подтверждённые факты, предположения и вопросы для проверки отдельно.

## Структура

- `materials/territory/` — ППО «Территория»
- `materials/territory-database/` — база данных, API и модели
- `materials/descriptor/` — АРМ «Дискриптор»
- `materials/deshifrator/` — программные компоненты и доступные фрагменты кода
- `materials/umms/` — UMMS SOAP и клиентская документация

## Источники и ограничения

Содержимое перенесено из ранее опубликованных репозиториев владельца:

- `ppo-territory-archive`
- `territory-docs`
- `descriptor-arm-spec`
- `deshifrator-docs`
- `umms-docs`

Тексты и исходные фрагменты сохранены в отдельных каталогах. Перенос файлов не переносит историю Git исходных репозиториев. Исходные проекты следует оставить доступными до завершения проверки ссылок, страниц и полноты материалов.

## Публикация

Сайт проекта: https://ekatmoz88-alt.github.io/territory-descriptor-unified/

