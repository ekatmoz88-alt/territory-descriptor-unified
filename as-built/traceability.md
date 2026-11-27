# Матрица трассировки As-Specified ↔ Architecture ↔ As-Built

| Область / требование | As-Specified | Architecture | As-Built | Статус доказательности |
|---|---|---|---|---|
| Единый АРМ и внутренние контуры | [Функциональные подсистемы](../specs/docs/02-functional-subsystems.md) | [Контекст и границы](../architecture/system-context-and-scope.ru.md) | [Инвентаризация реализации](code-inventory.md) | Контуры описаны; mapping к именам C# модулей требует проверки |
| Домен «Граждане» | [Процесс обработки данных](../specs/docs/08-data-processing-workflow.md) | [Контекст и границы](../architecture/system-context-and-scope.ru.md) | [UMMS и модели персоны](umms-client.md) | UI-модель поиска подтверждена; полный data flow не подтверждён |
| UMMS / SOAP | [Обмен данными](../specs/docs/04-data-exchange.md) | [Интеграционная граница](../architecture/data-exchange-and-administration.ru.md) | [UMMS client review](umms-client.md) | Внешний контракт обозначен; полный proxy/source отсутствует |
| Локальное хранение SQLite | [Спецификации компонентов](../specs/docs/03-hardware-software.md) | [Компонентные карты](../architecture/component-maps.md) | [SQLite DAL](sqlite-data-layer.md) | ConnectionFactory подтверждает только SQLite DAL |
| Файловый обмен и MRZ | [Data exchange requirements](../specs/docs/04-data-exchange.md) | [Файловый обмен](../architecture/data-exchange-and-mrz.md) | [Реконструкция исходников](../architecture/data-exchange-and-mrz.md) | Требуется проверять каждый формат по конкретному источнику |
| Испытания и дефекты | [ПМИ и ТЗ](../specs/README.md) | [Контуры ПОСС/ПОМС/ПОШ ВБД](../architecture/README.md) | [Отчёт и реестр дефектов](../verification/test-report-summary.md) | Статусы перенесены из отчёта от 24.11.2026 |
| Логическая модель данных | [Требования к данным](../specs/docs/02-functional-subsystems.md) | [Модель данных](../data-model/reconstructed-erd.md) | [DDL / миграции](../data-model/db/migrations/V001__init_tables.sql) | Реконструированная модель PostgreSQL, не production DB |

## Правила трассировки

- Один и тот же термин не означает тождество разных систем, сервисов и доменных областей.
- Неустановленные связи маркируются как требующие проверки.
- Статус «реализовано» в отчёте испытаний не равен независимому подтверждению исходным кодом.
