# SQLite Data Access Layer

## Область анализа

`ConnectionFactory.cs` находится в `DbStationary.Data` и относится к SQLite Data Access Layer. Его нельзя трактовать как реализацию ПОШ ВБД или внешнего UMMS SOAP-интеграционного контура.

## Связанные исходники

- [ConnectionFactory.cs](sources/DbStationary.Data/ConnectionFactory.cs)
- [SQLiteCommandEx.cs](sources/DbStationary.Data/SQLiteCommandEx.cs)
- [SQLiteDataReaderEx.cs](sources/DbStationary.Data/SQLiteDataReaderEx.cs)
- [SQLiteMaps.cs](sources/DbStationary.Data/SQLiteMaps.cs)

## Подтверждённая граница

Данные файлы подтверждают наличие локального слоя доступа к SQLite. Они не подтверждают структуру промышленной Oracle-БД, протокол обмена с ВБД или SOAP endpoint UMMS.
