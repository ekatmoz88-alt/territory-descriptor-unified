# PPO Territory and related technical systems

Evidence-based technical documentation for several separately documented systems and source collections. The repository is a documentation hub, not a claim that all contents form one deployed product.

## Architecture diagrams

- [Interactive architecture catalogue](materials/architecture/architecture.html) — bilingual HTML page with 10 Mermaid diagrams and an evidence-coverage matrix.
- [Architecture source (Markdown)](materials/architecture/README.md) — canonical diagram and evidence text; keep the HTML diagrams synchronized with this file.
- [System context and scope — RU](materials/architecture/system-context-and-scope.ru.md) · [EN](materials/architecture/system-context-and-scope.en.md) — bilingual system boundaries, PPO Territory architecture and deployment modes.
- [Data exchange and administration — RU](materials/architecture/data-exchange-and-administration.ru.md) · [EN](materials/architecture/data-exchange-and-administration.en.md) — historical export/import workflow, access permissions, file-based logs and identity-link records.
- [Detailed component maps](materials/architecture/component-maps.md) — 7 additional Mermaid diagrams for ARM Descriptor, PPO Territory projects, Deshifrator libraries and UMMS workflows.

## Documentation sections

| Section | Contents |
|---|---|
| [PPO Territory](materials/territory/README.md) | System purpose, functional modules, deployment, integrations, requirements and lifecycle |
| [Database and API](materials/territory-database/README.md) | Oracle, logical/physical structure, API and source-code models |
| [ARM Descriptor](materials/descriptor/README.md) | Mobile and stationary stations, data exchange, equipment and trust boundaries |
| [Software components](materials/deshifrator/README.md) | ModuleMobile, ModuleStationary, PassportPaint, dependencies, local storage, exchange and C# excerpts |
| [UMMS / SOAP](materials/umms/README.md) | SOAP API, client, local dossier storage and integration |
| [Supplementary source systems](materials/reference-systems/README.md) | Separately classified ARM PPZ/PVK, AS Passport RF and MSKTs materials; no integration is inferred |

## System-boundary policy

The materials are grouped for navigation only. This does not mean that every component is part of one executable product or that every architectural relationship has been established.

PPO Territory, ARM Descriptor, Deshifrator, UMMS, ARM PPZ/PVK, AS Passport RF and MSKTs are documented as separate boundaries or source tracks. Similar domain terms, shared historical organizations or adjacent source files do not prove a common runtime architecture.

In particular, the correspondence between ПОМС / ПОСС and ModuleMobile / ModuleStationary requires further verification against primary materials and source code.

## Evidence and publication policy

- Distinguish documented requirements, inspected source-code findings, logical reconstruction and unverified hypotheses.
- Do not invent modules, interfaces, database relations, protocols or deployment topology.
- Do not publish production credentials, personal data, private keys, protected network details or live exchange files.
- Historical product addresses and support contacts are source references, not verified current services.
- Keep original source projects available until links, published pages and material completeness have been checked.

## Structure

- `materials/territory/` — PPO Territory.
- `materials/territory-database/` — database, API and models.
- `materials/descriptor/` — ARM Descriptor.
- `materials/deshifrator/` — software components and available source excerpts.
- `materials/umms/` — UMMS SOAP and client documentation.
- `materials/reference-systems/` — other separately classified source materials.

## Publication

Project site: https://ekatmoz88-alt.github.io/territory-descriptor-unified/


## Tags

`architecture-catalogue` · `mermaid` · `enterprise-systems` · `ppo-territory` · `arm-descriptor` · `deshifrator` · `umms` · `en-ru`
