# Technical Documentation Portfolio — Architecture Catalogue

> **Interactive bilingual version:** [Open the EN/RU HTML architecture catalogue](./architecture.html). It renders the same 10 Mermaid diagrams as this Markdown source. Seven additional component-level diagrams are maintained in [component-maps.md](./component-maps.md).
>
> **Reusable Mermaid fragments:** [Open the Mermaid Patterns Library](./mermaid-patterns.md). It provides copy-and-adapt starting points for system context, deployment, component, data-flow, sequence, ER and state diagrams. These are reusable source snippets, not native Mermaid macros.
>
> **System context and scope:** [Русская версия](./system-context-and-scope.ru.md) · [English version](./system-context-and-scope.en.md). These companion documents explain the PPO Territory / ПО boundary, three-tier architecture, deployment modes and evidence limitations.
>
> **Data exchange and administration:** [Русская версия](./data-exchange-and-administration.ru.md) · [English version](./data-exchange-and-administration.en.md). Covers historical export/import workflows, file-based locking, user permissions, LOG records and technical identity links.
>
> **Access control:** [Русская версия](./access-control.ru.md) · [English version](./access-control.en.md). Includes the documented “Разрешить выгрузку / Allow data export” permission, its scope, limits and verification tests.

> **Evidence-based portfolio documentation.** This catalogue documents real project work across three related system and application areas: PPO Territory, ПО and UMMS. The related areas retain their distinct executable, deployment and runtime boundaries. Supplementary source collections are catalogued separately.

## How to read these diagrams

- **Documented** — directly stated in the available project documentation or visible in inspected source excerpts.
- **Derived view** — a logical grouping of documented elements for readability; it is not a recovered deployment configuration.
- **Not reproduced in the public catalogue** — restricted endpoint paths, internal ownership details and installation-specific topology may be omitted. The underlying systems and their API operations are real; an omitted route or configuration detail is not evidence that the interface did not exist.
- The 17-module count for PPO Territory is mentioned in source materials, but a complete authoritative list of all 17 modules has not been reconstructed. Unknown modules are intentionally not invented.
- PPO Territory, ПО and UMMS are documented as related areas of one project. Their system and runtime boundaries remain distinct wherever the available evidence supports that distinction.
- Supplementary ARM PPZ/PVK, AS Passport RF and MSKTs materials are indexed separately in [Supplementary source systems](../reference-systems/README.md). They are not merged into the diagrams below.

---

## 1. System landscape and boundaries

```mermaid
flowchart TB
  PROJECT["Related project areas"]
  TERR["PPO Territory<br/>three-tier information system"]
  DESH["ПО"]
  UMMS["UMMS<br/>client and SOAP service"]
  SUP["Supplementary source collections<br/>ARM PPZ/PVK · AS Passport RF · MSKTs"]
  PROJECT --> TERR
  PROJECT --> DESH
  PROJECT --> UMMS
  SUP -.->|catalogued separately| PROJECT
  TERR ---|"distinct system boundary"| DESH
  DESH ---|"distinct system boundary"| UMMS
```

**Boundary note.** The diagram is a portfolio-level derived view. It groups the three documented project areas without implying direct runtime integration between them. Supplementary source collections are indexed separately and are not treated as additional applications in this architecture.


## 2. PPO Territory — functional module map

```mermaid
flowchart TB
  subgraph TERR["PPO Territory"]
    CORE["CORE domain<br/>persons, identity data, documents,<br/>cases, addresses, payments"]
    DICT["DICT domain<br/>reference data"]
    RP["RP<br/>Russian passport"]
    FP["FP<br/>foreign passport"]
    REG["REG<br/>registration accounting"]
    MIG["MIG<br/>migration accounting"]
    OTHER["Other subject-area tables<br/>207 tables in the described DB inventory"]
    OTHERDOM["Named areas in available materials:<br/>citizenship, invitations, visas,<br/>asylum, labour migration"]
    MODCOUNT["17 functional modules are mentioned;<br/>full verified module-by-module inventory<br/>is not available yet"]
    CORE --> RP
    CORE --> FP
    CORE --> REG
    CORE --> MIG
    DICT --> RP
    DICT --> FP
    DICT --> REG
    DICT --> MIG
    OTHER --> OTHERDOM
    MODCOUNT -.->|inventory gap| OTHER
  end
```

**Inventory notes.** The database overview reports 401 tables: 44 `CORE_*`, 104 `DICT_*`, 11 `RP_*`, 10 `FP_*`, 17 `REG_*`, 8 `MIG_*`, and 207 in other subject areas. A separate physical specification contains 381 numbered entries. These figures come from different source documents and have not been reconciled; neither should be silently substituted for the other. The named subject areas above are not a verified one-to-one list of the 17 functional modules. Table counts are database inventory data, not module counts.

## 3. PPO Territory — Oracle database and logical data architecture

### 3.1 What is established

The available database overview identifies Oracle as the DBMS and reports an inventory of 401 tables grouped by naming prefixes. A separate physical specification lists 381 numbered entries. The two counts belong to different documents and have not been reconciled. This is evidence of database technology and source-specific inventories; it is **not** evidence of Oracle instance topology, physical storage layout, schema ownership, or application deployment.

```mermaid
flowchart TB
  DBMS["Oracle DBMS<br/>database technology identified in source materials"]
  subgraph INVENTORY["Reported table inventory — 401 tables"]
    CORE["CORE_* — 44 tables"]
    DICT["DICT_* — 104 tables"]
    RP["RP_* — 11 tables"]
    FP["FP_* — 10 tables"]
    REG["REG_* — 17 tables"]
    MIG["MIG_* — 8 tables"]
    OTHER["Other subject areas — 207 tables"]
  end
  DBMS --- INVENTORY
  NOTE["Inventory grouping only<br/>Not an owner/schema map or physical ERD"]
  INVENTORY -.-> NOTE
```

The prefix groups are an inventory classification from the available overview. They must not be treated as Oracle schema owners, tablespaces, application modules, or one-to-one functional module mappings unless Oracle metadata confirms that interpretation.

### 3.2 Conceptual entity relationships — provisional

```mermaid
erDiagram
  CORE_PERSON ||--o{ CORE_PERSONDATA : has_identity_versions
  CORE_PERSONDATA ||--o{ CORE_PERSONDATADOCUMENT : links
  CORE_DOCUMENT ||--o{ CORE_PERSONDATADOCUMENT : referenced_by
  CORE_PERSON ||--o{ CORE_PERSON_ADDRESS : has
  CORE_PERSON ||--o{ CORE_CITIZENSHIP : has
  CORE_PERSON ||--o{ CORE_PERSON_STATE : has
  CORE_CASE ||--o{ CORE_PERSON_CASE : specializes
  CORE_CASE ||--o{ CORE_OPERATION : records
  CORE_CASE ||--o{ CORE_CASE_PERSON_ENTITY : contains
  CORE_CASE ||--o{ CORE_CASE_PERSON_ADDRESS : records
  CORE_PERSON ||--o{ CORE_PERSON_CASE : subject_of
  CORE_DOCUMENT ||--o{ CORE_DOCUMENT_SCAN : has_scans
  CORE_CASE ||--o{ CORE_PAYDOC : may_reference
  DICT_REFERENCE ||--o{ CORE_DOCUMENT : classifies
```

**Model scope.** This is a conceptual ER model: it expresses logical entity relationships and is not the physical Oracle data model. The labels in the diagram identify conceptual data objects; they do not by themselves establish physical table names or database constraints. `DICT_REFERENCE` is a logical placeholder for dictionary data, not a confirmed Oracle table name.

### 3.3 Physical Oracle schema and dependency metadata

The physical Oracle model is a separate artefact. It describes actual database objects, columns, keys, constraints, ownership and object dependencies. To derive or verify it, use permitted Oracle metadata or a DDL-only export, subject to the database account's permissions:

- schema users and object inventory: `ALL_USERS`, `ALL_OBJECTS`;
- physical tables and columns: `ALL_TABLES`, `ALL_TAB_COLUMNS`;
- primary, foreign, unique and check constraints: `ALL_CONSTRAINTS`, `ALL_CONS_COLUMNS`;
- views, source code and triggers: `ALL_VIEWS`, `ALL_SOURCE`, `ALL_TRIGGERS`;
- object dependencies: `ALL_DEPENDENCIES`;
- grants and role privileges, where permitted: `ALL_TAB_PRIVS`, `ALL_ROLE_PRIVS`.

These Oracle views are metadata sources for the physical model; they are not part of the conceptual ER model. Use a permitted metadata-only or DDL-only export. Do not provide production table rows, personal data, passwords, connection strings, keys, or other production secrets.

## 4. PPO Territory — deployment architecture: evidence status

The available operational documentation now confirms that PPO Territory supports two operating modes: centralized and distributed. It also describes separate or combined application/database server placement. These are documented supported variants; the actual configuration of a particular region is still unknown.

```mermaid
flowchart TB
  subgraph CENTRAL["Centralized operating mode"]
    C_OFFICES["Territorial offices"]
    C_THIN["Thin clients"]
    C_APP["Single regional PPO Territory application instance"]
    C_DB[("Regional database")]
    C_OFFICES --> C_THIN --> C_APP --> C_DB
  end

  subgraph DISTRIBUTED["Distributed operating mode"]
    R_OFFICES["Offices with high-speed connectivity"]
    R_THIN["Thin clients"]
    R_APP["Regional application"]
    R_DB[("Regional database")]
    L_OFFICE["Office with unstable / unavailable link"]
    L_THIN["Local thin clients"]
    L_APP["Local application server"]
    L_DB[("Local database")]
    R_OFFICES --> R_THIN --> R_APP --> R_DB
    L_OFFICE --> L_THIN --> L_APP --> L_DB
    L_DB -->|Batch transfer or removable media; replication details to verify| R_DB
    R_DB -->|Batch transfer or removable media; replication details to verify| L_DB
  end
```

The documentation also specifies two server-placement alternatives: separate application and database servers, or a combined server. A distinct lower-capacity dedicated-server profile is described separately. See [Deployment Architecture](../territory/docs/03-deployment-architecture.md) and [Historical Platform Requirements](../territory/docs/05-platform-requirements.md).

The source does not establish actual regional topology, number of installed instances, replication protocol, conflict-resolution policy, failover nodes, or disaster-recovery arrangements. This is a documented-variants diagram, not a site-specific as-built deployment.

## 5. PPO Territory — external integration landscape

```mermaid
flowchart LR
  APP["PPO Territory<br/>application boundary"]
  IF["External exchange interfaces<br/>technical contracts not verified"]
  APP --- IF
  IF --- UIG["ЦБД УИГ<br/>visa / expulsion / deportation data<br/>direction not specified"]
  IF --> VYB["ПРИУР ГАС «Выборы»<br/>export / form 1.1 РИУР"]
  GIAC["ГИАЦ ГУ МВД<br/>responses / Криминал-И / offences"] --> IF
  IF --- ROS["Росстат<br/>forms 12-П and 12-В<br/>direction not specified"]
  ZAGS["ЗАГС<br/>birth / death records"] --> IF
  IF --- RP["АС «Российский паспорт»<br/>export path normalization<br/>direction not specified"]
  IF --- SK["СПО «Сервисный концентратор»<br/>СМЭВ / ЕПГУ / ФНС / ДКС МИД<br/>direction not specified"]
```

The diagram shows seven documented **external exchange areas**. Direction is explicit in the reviewed source only for three: export to ПРИУР ГАС «Выборы», and incoming information from ГИАЦ ГУ МВД and ЗАГС. The remaining four links are neutral because their direction is not established. These are not claims of verified live integrations. Protocols, endpoints, authentication, message schemas, ownership of each adapter, and current operational status are not established.

## 6. ПО — workstation and hardware/software boundary

```mermaid
flowchart TB
  OP["Operator"]
  STUI["Stationary station — workstation software"]
  STDATA["Stationary station — data / processing"]
  MOBUI["Mobile station — workstation software"]
  MOBDATA["Mobile station — data / processing"]
  EXCHANGE["Data exchange between stations<br/>details follow source specification"]
  HW["Peripheral equipment<br/>keyboard, pointing device, scanner,<br/>printer, laminator and other listed devices"]
  UNK["Exact component ownership, interfaces,<br/>message formats and deployment constraints<br/>must be verified against the complete specification"]
  OP --> STUI
  OP --> MOBUI
  STUI --> STDATA
  MOBUI --> MOBDATA
  STDATA --> EXCHANGE
  EXCHANGE --> STDATA
  EXCHANGE --> MOBDATA
  MOBDATA --> EXCHANGE
  HW --- STUI
  HW --- MOBUI
  EXCHANGE -.-> UNK
```

This is a system decomposition from the ARM description: stationary and mobile stations, user interaction, peripherals, and an exchange boundary. It does not assert a specific network protocol or a particular physical connection for every peripheral.

## 7. ПО — application suite and component architecture

```mermaid
flowchart TB
  subgraph SUITE["ПО application suite"]
    OCRAPP["OCR component"]
    MOBILE["ModuleMobile.exe"]
    STATIONARY["ModuleStationary.exe"]
    PRINT["Printer / PassportPaint"]
  end
  subgraph OCRPARTS["OCR component — documented implementation"]
    OCR["Tesseract OCR 3.02"]
  end
  subgraph MOBILEPARTS["ModuleMobile — documented components"]
    MUI["WPF user interface"]
    MOBDB[("ModuleMobile.db3")]
    SOAP["UMMS SOAP client configuration"]
    FILEOUT["File exchange / removable media"]
  end
  subgraph STPARTS["ModuleStationary — documented components"]
    SUI["WPF user interface"]
    STDB[("ModuleStationary.db3")]
    SQLITE["SQLite data access"]
    FIAS["FIAS endpoint configuration"]
    ELASTIC["Elasticsearch search service"]
  end
  subgraph PRINTPARTS["Printer / PassportPaint — document output"]
    LAYOUT["Passport / document layouts"]
    MRZ["MRZ and print formatting"]
    OUTPUT["Print-view / output generation"]
  end
  OCRAPP --> OCR
  MOBILE --> MUI
  MOBILE --> MOBDB
  MOBILE --> SOAP
  MOBILE --> FILEOUT
  STATIONARY --> SUI
  STATIONARY --> STDB
  STATIONARY --> SQLITE
  MOBILE -.->|FIAS endpoint configured| FIAS
  STATIONARY -.->|FIAS endpoint configured| FIAS
  FIAS --> ELASTIC
  PRINT --> LAYOUT
  LAYOUT --> MRZ --> OUTPUT
```

**Boundary warning.** The diagram distinguishes the OCR component, `ModuleMobile.exe`, `ModuleStationary.exe` and `Printer / PassportPaint`. Tesseract OCR 3.02 is assigned to the OCR component; MRZ and print formatting are grouped under `Printer / PassportPaint`. The two SQLite databases and UMMS SOAP client configuration are shown under their documented applications. FIAS endpoint configuration is associated with both mobile and stationary applications. A direct runtime call from `ModuleStationary` to `Printer / PassportPaint` is not established by the reviewed excerpts and is therefore not drawn.

## 8. ПО — SQLite data-access components

```mermaid
flowchart LR
  APP["Application code"]
  CMD["SQLiteCommandEx&lt;T&gt;<br/>command execution / result mapping"]
  PARAM["SQLiteCommandEx_Params<br/>typed parameter helpers"]
  FACTORY["ConnectionFactory<br/>shared SQLiteConnection"]
  READER["SQLiteDataReaderEx<br/>column access / ordinal cache"]
  MAP["SQLiteMaps<br/>row-to-model mapping"]
  MODEL["Application models"]
  DB[("MainDB.db3")]
  APP --> CMD
  APP --> PARAM
  CMD --> FACTORY
  FACTORY --> DB
  CMD --> READER
  READER --> MAP
  MAP --> MODEL
```

The component names and responsibilities are based on reviewed C# excerpts. Connection lifetime, concurrency, disposal, null handling, and reader behavior are recorded as review findings in the data-access review; this diagram does not imply those risks have been resolved.

## 9. UMMS — client and SOAP service boundary

```mermaid
flowchart LR
  CLIENT_UI["UMMS client — UI / workflow"]
  PERSON_SEARCH["Person and dossier search"]
  CASE_HANDLING["Case and dossier handling"]
  DOC_WORKFLOW["Document issue / rollback workflow"]
  LOCAL_STORAGE["Local case and dossier storage"]
  SOAP_CLIENT["UMMS SOAP client"]
  UMMS_SERVICE["UMMS SOAP service"]
  SERVICE_OPERATIONS["Operations:<br/>searchPersonFile<br/>getPersonDocuments<br/>getPersonAddresses<br/>getPersonCasesInfo<br/>getDocumentDetail<br/>getAddressDetail<br/>getCountryDictionary<br/>issueNewDocument<br/>rollbackIssueNewDocument"]
  CLIENT_UI --> PERSON_SEARCH
  CLIENT_UI --> CASE_HANDLING
  CLIENT_UI --> DOC_WORKFLOW
  CASE_HANDLING --> LOCAL_STORAGE
  LOCAL_STORAGE --> CASE_HANDLING
  PERSON_SEARCH --> SOAP_CLIENT
  DOC_WORKFLOW --> SOAP_CLIENT
  SOAP_CLIENT -->|SOAP XML contract| UMMS_SERVICE
  UMMS_SERVICE -->|SOAP XML response| SOAP_CLIENT
  UMMS_SERVICE --> SERVICE_OPERATIONS
```

The operation names are taken from the public API description and source-review notes. Exact SOAP envelopes, namespaces, SOAPAction values, schemas, authentication, error contracts, and endpoint details must be verified against the WSDL and approved integration documentation.

---

## 10. Coverage and remaining verification

| System / area | Architecture views included | Remaining evidence needed |
|---|---|---|
| PPO Territory | Functional domains, conceptual data model, centralized/distributed deployment variants, separate/combined server placement, seven external exchange areas (three with documented direction) | Authoritative list of all 17 modules; complete physical ERD; adapter contracts; actual regional topology; synchronization rules |
| ПО — workstation specification | Stationary/mobile workstation decomposition, peripherals, exchange boundary | Full component inventory, hardware mapping, interface/control descriptions, verified data-flow details |
| ПО | OCR component (Tesseract OCR 3.02), ModuleMobile.exe, ModuleStationary.exe, Printer/PassportPaint (MRZ and printing), separate SQLite databases | Complete source tree, project references, executable ownership per feature, full schema and runtime configuration |
| UMMS | Client/service boundary, SOAP operations, search sequence | WSDL/XSD, exact service contract, full client source, deployment and security configuration |
| Supplementary systems | Separate source notes for ARM PPZ/PVK, AS Passport RF and MSKTs | Original covers, version/revision, ownership and any actual integration evidence |

## 11. Evidence and change policy

- Keep documented facts separate from derived views and explicitly label provisional models.
- Preserve conflicting source inventories with their provenance; do not reconcile counts without authoritative evidence.
- Do not infer deployment topology, integration direction, protocol, ownership or runtime behaviour from a neutral relationship or an omitted detail.
- Update a diagram only when a source document, inspected source excerpt or verified metadata supports the change.
- Record unresolved questions in the relevant section and in the coverage table instead of filling gaps with assumptions.
