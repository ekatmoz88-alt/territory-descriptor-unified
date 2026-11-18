# ППО ID — Technical Documentation

Evidence-based documentation for the PPO Territory project and its related system boundaries. The project includes the PPO Territory information system and the Deshifrator workstation application as distinct applications with separate runtime boundaries; UMMS is documented as a related system boundary. This repository is a documentation hub, not a single executable product.

## Architecture diagrams

- [Interactive architecture catalogue](materials/architecture/architecture.html) — bilingual HTML page with 10 Mermaid diagrams and an evidence-coverage matrix.
- [Architecture source (Markdown)](materials/architecture/README.md) — canonical diagram and evidence text; keep the HTML diagrams synchronized with this file.
- [Source-based reconstruction of the Deshifrator-14 / PPO Territory diagrams](materials/architecture/deshifrator-14-source-reconstruction.ru.md) — source diagrams and analysis: component interaction, federal SАПД/SЗД/FХД architecture, application layers, sequence diagrams, conflict workflow, trust levels and dossier lifecycle.
- [System context and scope — RU](materials/architecture/system-context-and-scope.ru.md) · [EN](materials/architecture/system-context-and-scope.en.md) — bilingual system boundaries, PPO Territory architecture and deployment modes.
- [Data exchange and administration — RU](materials/architecture/data-exchange-and-administration.ru.md) · [EN](materials/architecture/data-exchange-and-administration.en.md) — export/import workflow, file-based logs and identity-link records.
- [Access control — RU](materials/architecture/access-control.ru.md) · [EN](materials/architecture/access-control.en.md) — permission catalogue, including the documented “Allow data export” right.
- [Detailed component maps](materials/architecture/component-maps.md) — 7 additional Mermaid diagrams for ППО ID, PPO Territory projects, Deshifrator libraries and UMMS workflows.

## Documentation sections

| Section | Contents |
|---|---|
| [PPO Territory](materials/territory/README.md) | Information-system documentation within the unified PPO Territory project contour |
| [Database and API](materials/territory-database/README.md) | Oracle, logical/physical structure, API and source-code models |
| [Deshifrator workstation specification](materials/descriptor/README.md) · [software components](materials/deshifrator/README.md) | The same Deshifrator application: workstation specification, ModuleMobile, ModuleStationary, Printer / PassportPaint, data exchange, local storage, dependencies and C# excerpts. Historical «Дискриптор» is an alternate source label, not a separate project. |
| [UMMS / SOAP](materials/umms/README.md) | SOAP API, client, local dossier storage and integration |
| [Supplementary source systems](materials/reference-systems/README.md) | Separately classified ARM PPZ/PVK, AS Passport RF and MSKTs materials; no integration is inferred |

## System-boundary policy

The materials are grouped for navigation only. This does not mean that every component is part of one executable product or that every architectural relationship has been established.

ППО «Территория» is the umbrella project. The PPO Territory information system and the Deshifrator workstation application (historically labelled ARM «Дискриптор» in some source materials) are distinct application/system boundaries within that project; the legacy label does not identify a second project. UMMS is documented as a related but separate system boundary. ARM PPZ/PVK, AS Passport RF and MSKTs remain separate supplementary source tracks. The independent Oracle DMRS / GLOBAL11 project is outside this repository. Oracle DBMS references in PPO Territory materials describe the database technology identified for that system and must not be conflated with the separate Oracle project.

In particular, the correspondence between ПОМС / ПОСС and ModuleMobile / ModuleStationary requires further verification against primary materials and source code.

## Evidence and publication policy

- Distinguish documented requirements, inspected source-code findings, logical reconstruction and unverified hypotheses.
- Do not invent modules, interfaces, database relations, protocols or deployment topology.
- Do not publish production credentials, personal data, private keys, protected network details or live exchange files.
- Historical product addresses and support contacts are source references, not verified current services.
- Keep original source projects available until links, published pages and material completeness have been checked.

## Structure

- `materials/territory/` — PPO Territory.
- `materials/territory-database/` — PPO Territory database, API and models; Oracle here refers to the DBMS identified in the PPO Territory source materials, not the independent Oracle DMRS / GLOBAL11 project.
- `materials/descriptor/` — Deshifrator workstation specification (legacy source label: ARM «Дискриптор»).
- `materials/deshifrator/` — complementary software-component documentation and available source excerpts for the same Deshifrator project.
- `materials/umms/` — UMMS SOAP and client documentation.
- `materials/reference-systems/` — other separately classified source materials.

## Publication

Project site: https://ekatmoz88-alt.github.io/territory-descriptor-unified/

## Tags

`architecture-catalogue` · `mermaid` · `enterprise-systems` · `ppo-id` · `ppo-territory` · `deshifrator` · `umms` · `en-ru`
