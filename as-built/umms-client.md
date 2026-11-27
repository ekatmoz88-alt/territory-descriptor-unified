# external SOAP service client boundary and person models

## Архитектурная граница

внешний SOAP-сервис рассматривается как внешняя интеграционная система/сервис. «Граждане» — функциональная область внутри АРМ для работы с досье физических лиц; это не синоним external SOAP service.

## Сопоставление моделей персоны

Обе модели используют `Common.Data.Models.Umms.UmmsPersonModel` как источник значений и находятся в namespace `Common.Wpf.ViewModels`.

| Свойство | `UmmsPersonViewModel` | `UmmsSearchPersonResultViewModel` |
|---|---|---|
| `PersonId` | Копирует в settable property | Возвращает значение через `UmmsSearchPersonResult` |
| `Name` | Копирует в settable property | Возвращает значение через `UmmsSearchPersonResult` |
| `DateOfBirth` | Копирует в settable property | Возвращает значение через `UmmsSearchPersonResult` |
| `DateOfDeath` | Копирует в settable property | Возвращает значение через `UmmsSearchPersonResult` |
| `PlaceOfBirth` | Копирует в settable property | Возвращает значение через `UmmsSearchPersonResult` |
| `LastIssuedDocument` | Копирует в settable property | Возвращает значение через `UmmsSearchPersonResult` |
| `HidingAttribute` | Копирует в settable property | Возвращает значение через `UmmsSearchPersonResult` |
| `Index` | Есть | Есть |
| `IsOpened` | Есть; setter вызывает `OnPropertyChanged()` | Есть; setter вызывает `OnPropertyChanged()` |
| `ScenarioNumber` | Есть | Не найдено |
| `ScenarioStatus` | Есть | Не найдено |

### Вывод по моделям

- `UmmsPersonViewModel` содержит копируемые свойства и два дополнительных поля сценария (`ScenarioNumber`, `ScenarioStatus`). В XML-комментарии указано назначение для stationary module.
- `UmmsSearchPersonResultViewModel` хранит ссылку на исходную модель в `UmmsSearchPersonResult` и предоставляет read-only forwarding properties для основных атрибутов.
- Обе модели — WPF ViewModel-слой. Они сами по себе не доказывают сетевой вызов, SOAP endpoint, авторизацию или контракт сериализации.

## Исходники

- [`UmmsPersonViewModel.cs`](sources/Common.Wpf.ViewModels/UmmsPersonViewModel.cs) — библиотечный исходник от 24.11.2026.
- [`UmmsSearchPersonResultViewModel.cs`](sources/Common.Wpf.ViewModels/UmmsSearchPersonResultViewModel.cs) — исходник из репозитория.

## external SOAP service proxy и расхождение источников

- Полный `UmmsNp.cs` в публичном дереве не найден.
- В диагностической трассировке упоминается `Umms.NpWSService.processS2(...)` и позиция в `UmmsNp.cs`. Это подтверждает след вызова, но не реализацию метода.
- В опубликованной HTML-документации SOAP-прокси сказано, что конкретная версия generated `UmmsNp.cs` содержит сценарий №1, а операции сценариев 2–4 отсутствуют. Диагностическая трассировка при этом указывает на `processS2`. Это противоречие требует сверки версии proxy и WSDL; его нельзя разрешать предположением.
- `UmmsNpImplService` упомянут в отчёте испытаний от 24.11.2026, но его реализация в проверенном публичном дереве не найдена.

## Требуется для закрытия пробелов

1. Получить исходные версии `UmmsNp.cs` и реализации `UmmsNpImplService`.
2. Сверить generated proxy с WSDL/XSD и диагностической трассировкой.
3. Подтвердить endpoint, авторизацию, сериализацию и фактический runtime flow.
