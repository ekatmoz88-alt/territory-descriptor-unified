# UMMS — Public Technical Documentation

Public technical documentation and source-based analysis for the historical UMMS document-processing system and its SOAP integration.

**Published documentation:** https://ekatmoz88-alt.github.io/umms-docs/

## Scope

This repository contains selected public materials describing the UMMS API, client-side workflows, local case and dossier storage, and the relationship between workstation roles and the observed SOAP integration.

It is a historical documentation and analysis project. It does not claim that the original system was implemented on .NET 8, and it is separate from the Deshifrator application suite, ARM Descriptor, FMS Territory, and the Passport Account System.

## Public documents

| File | Subject |
|---|---|
| [01_API_ПУБЛИЧНАЯ.md](01_API_ПУБЛИЧНАЯ.md) | Public overview of the UMMS API and its operations |
| [02_Клиент_ПУБЛИЧНАЯ.md](02_Клиент_ПУБЛИЧНАЯ.md) | Public overview of the client application and workflows |
| [05_Локальное_хранение_досье_ПУБЛИЧНАЯ.md](05_Локальное_хранение_досье_ПУБЛИЧНАЯ.md) | Source-based review of local case and dossier storage |
| [06_АРМ_и_SOAP_интеграция_ПУБЛИЧНАЯ.md](06_АРМ_и_SOAP_интеграция_ПУБЛИЧНАЯ.md) | Workstation overview and SOAP integration analysis, with provisional paths identified explicitly |
| [index.html](index.html) | Published HTML overview |

## Evidence boundaries

The materials distinguish documented system descriptions, inspected source-code evidence, runtime observations and provisional integration hypotheses. Findings in the source reviews are limited to the files and excerpts actually inspected; they should not be read as a complete source-code audit.

The public repository does not include the complete application source tree or internal documentation. No live production endpoint, production credentials, personal data, private keys or actual exchange files are published.

## Related projects

- [Deshifrator documentation](https://github.com/ekatmoz88-alt/deshifrator-docs) — separate historical desktop application suite.
- [ARM Descriptor documentation](https://github.com/ekatmoz88-alt/descriptor-arm-spec) — separate document-processing workstation.
- [FMS Territory archive](https://github.com/ekatmoz88-alt/ppo-territory-archive) — separate enterprise information system.
- [Passport Account System documentation](https://github.com/ekatmoz88-alt/territory-docs) — separate passport-accounting system.

## Documentation approach

This repository uses Markdown and a static HTML publication. Technical claims are kept within the available documentary and source evidence; items that need further primary-source confirmation are marked as provisional or unverified.


## Architecture

- [Architecture catalogue](../architecture/README.md)
- [Detailed module and component maps](../architecture/component-maps.md)
