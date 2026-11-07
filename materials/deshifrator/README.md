# Deshifrator — Desktop Application Documentation

**Published documentation:** https://ekatmoz88-alt.github.io/deshifrator-docs/

Public technical documentation for the historical Deshifrator desktop application. The materials are based on available project descriptions and selected source-code excerpts; they are not a complete specification or a full source-code audit.

## Documentation

- [Architecture and components](docs/architecture.md)
- [Application suite review: ModuleMobile, ModuleStationary, Printer / PassportPaint](docs/application-suite-review.md)
- [SQLite data-access layer review](docs/data-access-review.md)
- [Repository contents and evidence boundaries](docs/repository-completeness.md)
- [File exchange and MRZ](docs/data-exchange-and-mrz.md)
- [Technical risks and engineering decisions](docs/risks-and-decisions.md)
- [Dependencies, configuration, and runtime boundaries](docs/dependencies-and-runtime.md)

## Source excerpts

The repository includes selected C# files for the SQLite data-access layer in [sources/DbStationary.Data](sources/DbStationary.Data/). These are review excerpts, not a complete application source tree.

## Architecture boundary

This repository documents the historical **АРМ «Дешифратор»** application suite (ModuleMobile, ModuleStationary, and Printer / PassportPaint). It is a separate research track from the independently specified **АРМ «Дискриптор»**. Similar words such as “mobile station” and “stationary station” do not establish that the two systems are the same product or share components.

ПОСС, ПОМС, ПОШ ВБД, and the Oracle GLOBAL11 demo data model are not treated as components of the Deshifrator application in this repository. No relationship between the Oracle model and this WPF application suite is established by the available evidence.

## Technology context

The supplied packages target .NET Framework 4.5 and include WPF components, SQLite, Tesseract OCR, Elasticsearch 1.2.1, and separate mobile/stationary modules. The mobile configuration contains the UMMS SOAP endpoint. A possible .NET 8 migration is mentioned in project materials, but its scope and completion status are unverified.

## Publication and evidence boundaries

The public version must not contain credentials, cryptographic key material, personal data, production service addresses, connection strings, or actual exchange files. Environment-specific endpoints are excluded from public examples.

This project was documented as part of the author's work at Scientific Instruments, Inc. (2014–2016). The content describes the historical technical context and does not imply that the listed component versions are currently in use.
