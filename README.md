# ППО ПАК / PPO PAK — Technical Documentation

[![CI](https://github.com/ekatmoz88-alt/territory-descriptor-unified/workflows/CI/badge.svg)](https://github.com/ekatmoz88-alt/territory-descriptor-unified/actions)

---

## Overview

Evidence-based documentation for the PPO PAK project and its related system boundaries. The project includes the PPO PAK information system and the Dossier Processing Workstation as distinct applications with separate runtime boundaries; UMMS is documented as a related system boundary. This repository is a documentation hub, not a single executable product.

## Solved Problems

- Documenting system boundaries between PPO PAK information system and ARM «Дешифратор»
- Integrating UMMS/SOAP while preserving system boundaries
- Maintaining evidence-based architectural reconstruction
- Separating historical notation from current functional distinctions

## System Boundaries & Module Composition

| Module | Description | Boundary Status |
|---|---|---|
| ППО «Территория» | PPO PAK information system — modular web application with client web interface, application server, and database server | Separate application boundary |
| АРМ «Дешифратор» | Specialized document formatting application with stationary and mobile software stations | Preserves own application and execution boundaries |
| Интеграция UMMS/SOAP | SOAP API, client, local dossier storage and integration with boundary preservation | Related but separate system boundary |

## C1 System Context Diagram

```mermaid
flowchart LR
  "\"PPO PAK Information System\"\" --> "\"ARM «Дешифратор»\""
  "\"PPO PAK Information System\"\" --> "\"UMMS/SOAP\""
  "\"External Actors\"\" --> "\"PPO PAK Information System\""
```

## Technology Stack

- **Documentation framework**: Docsify
- **Diagram engine**: Mermaid
- **Markdown processing**: Python-based validator
- **Deployment**: GitHub Pages rsync

## Documentation Navigation

- [Architecture catalogue](materials/architecture/README.md)
- [System context and scope — RU](materials/architecture/system-context-and-scope.ru.md) · [EN](materials/architecture/system-context-and-scope.en.md)
- [Data exchange and administration — RU](materials/architecture/data-exchange-and-administration.ru.md) · [EN](materials/architecture/data-exchange-and-administration.en.md)
- [Access control — RU](materials/architecture/access-control.ru.md) · [EN](materials/architecture/access-control.en.md)
- [PPO PAK](materials/territory/README.md)
- [Database and API](materials/territory-database/README.md)
- [Dossier Processing Workstation](materials/descriptor/README.md)
- [UMMS / SOAP](materials/umms/README.md)
- [Supplementary source systems](materials/reference-systems/README.md)

## Evidence & Sanitization Notice

- **Evidence status**: Source-based / Anonymized
- **CI**: Configured (GitHub Actions)
- **PII Review**: Binary source files (.pdf, .odg, .wmf) excluded from public build
- **Evidence policy**: Preserve original source archive and canonical evidence records
- **Sanitization**: Local paths (/media/, /home/) and PII excluded from public build

---

## Evidence and publication policy

- Distinguish documented requirements, inspected source-code findings, logical reconstruction and unverified hypotheses
- Do not invent modules, interfaces, database relations, protocols or deployment topology
- Do not publish production credentials, personal data, private keys, protected network details or live exchange files
- Historical product addresses and support contacts are source references, not verified current services
- Preserve the original source archive and the canonical evidence records; duplicate documentation repositories are reduced to redirect pointers after their unique content is merged

## Evidence & Quality Governance

- **Evidence status**: Source-based / Anonymized
- **CI**: Configured (GitHub Pages rsync deployment)
- **PII Review**: Pending — binary source files (.pdf, .odg, .wmf, including uppercase extensions) are excluded from the public build; this does not certify the remaining content as PII-free
- **Evidence policy**: [Evidence & documentation quality policy](https://ekatmoz88-alt.github.io/github-profile-dashboard-vite/#evidence-policy)

## Structure

- `materials/territory/` — PPO PAK.
- `materials/territory-database/` — PPO PAK database, API and models; Oracle here refers to the DBMS identified in the PPO PAK source materials, not the independent Oracle DMRS / GLOBAL11 project.
- `materials/descriptor/` — Dossier Processing Workstation specification (historical source notation: «ППО ПАК»).
- `materials/deshifrator/` — software-component documentation and available source excerpts for the Dossier Processing Workstation.
- `materials/umms/` — UMMS SOAP and client documentation.
- `materials/reference-systems/` — other separately classified source materials.

## Publication

Project site: https://ekatmoz88-alt.github.io/territory-descriptor-unified/

## Tags

`architecture-catalogue` · `mermaid` · `enterprise-systems` · `ppo-pak` · `umms` · `en-ru`