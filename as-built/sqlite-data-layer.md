# SQLite Data Access Layer

## Область анализа

`ConnectionFactory.cs` находится в `DbStationary.Data` и относится к SQLite Data Access Layer. Его нельзя трактовать как реализацию ПОШ ВБД или внешнего UMMS SOAP-интеграционного контура.

## Связанные исходники

- [ConnectionFactory.cs](../materials/deshifrator/sources/DbStationary.Data/ConnectionFactory.cs)
- [SQLiteCommandEx.cs](../materials/deshifrator/sources/DbStationary.Data/SQLiteCommandEx.cs)
- [SQLiteDataReaderEx.cs](../materials/deshifrator/sources/DbStationary.Data/SQLiteDataReaderEx.cs)
- [SQLiteMaps.cs](../materials/deshifrator/sources/DbStationary.Data/SQLiteMaps.cs)

## Подтверждённая граница

Данные файлы подтверждают наличие локального слоя доступа к SQLite. Они не подтверждают структуру промышленной Oracle-БД, протокол обмена с ВБД или SOAP endpoint UMMS.
