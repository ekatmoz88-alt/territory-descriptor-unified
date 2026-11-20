# PPO ID Docs — Architecture, Database, API and Source-Code Documentation

[English](README.en.md) | [Русский](README.md)

**Documentation website:** https://ekatmoz88-alt.github.io/territory-descriptor-unified/materials/territory-database/

This repository contains technical documentation for PPO ID Docs, covering its Oracle information database, domain modules, source-code structure, API materials and documented relationships between them.

## Documentation sections

- [Architecture overview](../architecture/) — context, software components, Oracle data model, API/model/database traceability and evidence status.
- [Database and data models](./database/index.md) — Oracle structure, CORE and DICT groups, domain modules, relationships and ER materials.
- [Source code and models](./source-code/index.md) — project structure, software components and code-to-database model mapping.
- [API operations](./api/index.md) — JSON operations, request fields, database mappings, validation and rollback behavior.

## Technology and documentation approach

- Oracle Database
- C# / .NET project structure
- SQL and JSON
- Markdown and VitePress
- Git, GitHub Actions and GitHub Pages
- Mermaid architecture diagrams

## Evidence and limitations

PPO ID Docs is documented as a real information system deployed and operated in an office-server environment. The public documentation is based on project materials, system descriptions and source code. Architecture views distinguish documented relationships from logical reconstructions that cannot be derived directly from the available artefacts.

The office server was not accessible from the author's personal laptop during documentation work. This limitation does not establish that API routes or working operations did not exist. The current server and database state has not been revalidated during publication.

The database inventory reports 401 tables. A separate physical-structure document contains 381 numbered entries. These figures come from different documentary sources and are not interchangeable; the reason for the difference has not been established.

## Tags

`ppo-id-docs` · `oracle` · `database-documentation` · `system-architecture` · `api-documentation` · `docs-as-code`
