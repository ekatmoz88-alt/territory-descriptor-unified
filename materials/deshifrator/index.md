# АРМ «Дешифратор»

Публичная техническая документация одного приложения в проектном контуре ППО «Территория». Историческое написание «Дискриптор» обозначает тот же проект, а не отдельное АРМ.

## Проектная спецификация и логическая архитектура

- [Спецификация АРМ и функциональных подсистем](../descriptor/README.md)
- [Системный контекст и границы](../architecture/system-context-and-scope.ru.md)
- [Архитектурный каталог](../architecture/README.md)

## Программные компоненты и исходники

- [Архитектура и компоненты](docs/architecture.md)
- [Обзор ModuleMobile / ModuleStationary / PassportPaint](docs/application-suite-review.md)
- [Обзор исходной архитектуры](docs/architecture-source-review.md)
- [Слой доступа к данным SQLite](docs/data-access-review.md)
- [Зависимости, конфигурация и runtime](docs/dependencies-and-runtime.md)
- [Файловый обмен и MRZ](docs/data-exchange-and-mrz.md)
- [Печать документов](docs/printing-documents.md)
- [Описание программы](docs/program-description.md)
- [Риски и инженерные решения](docs/risks-and-decisions.md)
- [Технический долг](docs/risks-and-tech-debt.md)
- [Оценка миграции на .NET 8](docs/migration-to-net8.md)
- [Состав материалов и границы доказательности](docs/repository-completeness.md)

Проектное описание ПОСС/ПОМС/ПОШ ВБД и анализ выбранных исходников рассматриваются в одном проектном контуре, но как разные уровни документации и доказательств. Связь между логическими подсистемами и конкретными модулями исходного кода отмечается как подтверждённая только при наличии прямых свидетельств.
