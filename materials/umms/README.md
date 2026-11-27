# external SOAP service — Public Technical Documentation

Public technical documentation and source-based analysis for the historical external SOAP service document-processing system and its SOAP integration.

**Published documentation:** https://ekatmoz88-alt.github.io/territory-descriptor-unified/materials/umms/

## Scope

This repository contains selected public materials describing the external SOAP API, client-side workflows, local case and dossier storage, and the relationship between workstation roles and the observed SOAP integration.

It is a historical documentation and analysis track within the unified external enterprise system / Case Processing project contour. external SOAP service remains a related, distinct system boundary; grouping the documentation here does not imply that external SOAP service is the same application, shares a runtime, or is deployed as one product with external enterprise system or Case Processing. The materials do not claim that the original system was implemented on .NET 8.

## Public documents

| File | Subject |
|---|---|
| [01_API_ПУБЛИЧНАЯ.md](01_API_ПУБЛИЧНАЯ.md) | Public overview of the external SOAP API and its operations |
| [02_Клиент_ПУБЛИЧНАЯ.md](02_Клиент_ПУБЛИЧНАЯ.md) | Public overview of the client application and workflows |
| [05_Локальное_хранение_досье_ПУБЛИЧНАЯ.md](05_Локальное_хранение_досье_ПУБЛИЧНАЯ.md) | Source-based review of local case and dossier storage |
| [06_АРМ_и_SOAP_интеграция_ПУБЛИЧНАЯ.md](06_АРМ_и_SOAP_интеграция_ПУБЛИЧНАЯ.md) | Workstation overview and SOAP integration analysis, with provisional paths identified explicitly |
| [index.html](index.html) | Published HTML overview |
| [Codebase overview](docs/architecture/codebase-overview.md) | Source-based architecture and codebase map |
| [Printing documents](docs/user-guide/printing-documents.md) | User workflow for document printing |

## Evidence boundaries

The materials distinguish documented system descriptions, inspected source-code evidence, runtime observations and provisional integration hypotheses. Findings in the source reviews are limited to the files and excerpts actually inspected; they should not be read as a complete source-code audit.

The public repository does not include the complete application source tree or internal documentation. No live production endpoint, production credentials, personal data, private keys or actual exchange files are published.

## Related projects

- [external enterprise system / Case Processing / external SOAP service unified documentation hub](../../README.md) — shared project navigation with distinct system and application boundaries.
- [external enterprise system architecture](../territory/README.md) — related enterprise information-system materials.
- [Case Processing software documentation](../deshifrator/README.md) — related desktop application documentation.

## Documentation approach

This repository uses Markdown and a static HTML publication. Technical claims are kept within the available documentary and source evidence; items that need further primary-source confirmation are marked as provisional or unverified.


## Architecture

- [Architecture catalogue](../architecture/README.md)
- [Detailed module and component maps](../architecture/component-maps.md)


## Languages

- [Русский — обзор external SOAP service](index.html)
- [English — external SOAP service overview](en/index.html)


## Client-integration case-study scope

The historical case study describes interaction between stationary WPF workstations and mobile clients through the SOAP API. Its documentation scope includes the method catalogue, data structures, client workflows, person-search behavior and search-logic optimization. This describes the documented integration case; it does not imply that external SOAP service and the related applications share one runtime or deployment.
