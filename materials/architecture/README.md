# Architecture catalogue — Territory, Descriptor, Deshifrator and UMMS

> **Evidence-based portfolio documentation.** This catalogue separates four independently documented systems and their component boundaries. Supplementary source collections are catalogued separately. This is not a claim that the systems form one deployed product.

## How to read these diagrams

- **Documented** — directly stated in the available project documentation or visible in inspected source excerpts.
- **Derived view** — a logical grouping of documented elements for readability; it is not a recovered deployment configuration.
- **Unverified** — exact protocols, endpoints, ownership, runtime topology, or internal module responsibilities are not established by the available evidence.
- The 17-module count for PPO Territory is mentioned in source materials, but a complete authoritative list of all 17 modules has not been reconstructed. Unknown modules are intentionally not invented.
- ARM «Дискриптор», Deshifrator, PPO Territory, and UMMS are kept as separate system boundaries. Similar terms do not prove that they are one product.
- Supplementary ARM PPZ/PVK, AS Passport RF and MSKTs materials are indexed separately in [Supplementary source systems](../reference-systems/README.md). They are not merged into the diagrams below.

---

## 1. System landscape and boundaries

```mermaid
flowchart TB
  subgraph LANDSCAPE["Separate documented system boundaries"]
    TERR["PPO Territory<br/>FMS enterprise information system"]
    DESC["ARM Descriptor<br/>document-processing workstation"]
    DESH["Deshifrator<br/>historical desktop application suite"]
    UMMS["UMMS<br/>SOAP API and client workflows"]
  end

  TERR -. "No shared runtime boundary established" .- DESC
  DESC -. "Not the same product" .- DESH
  DESH -. "Separate documentation track" .- UMMS
  TERR -. "Separate system" .- UMMS

  OTHER["Supplementary source tracks:<br/>ARM PPZ/PVK · AS Passport RF · MSKTs"]
  OTHER -. "No integration inferred" .- LANDSCAPE
```

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
    MODCOUNT -. "inventory gap" .- OTHER
  end
```

**Inventory notes.** The database overview reports 401 tables: 44 `CORE_*`, 104 `DICT_*`, 11 `RP_*`, 10 `FP_*`, 17 `REG_*`, 8 `MIG_*`, and 207 in other subject areas. The named subject areas above are not a verified one-to-one list of the 17 functional modules. Table counts are database inventory data, not module counts.

## 3. PPO Territory — Oracle database and logical data architecture

### 3.1 What is established

The available database overview identifies Oracle as the DBMS and reports an inventory of 401 tables grouped by naming prefixes. This is evidence of the database technology and table inventory; it is **not** evidence of Oracle instance topology, physical storage layout, schema ownership, or application deployment.

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

**Model interpretation.** This ER view is a conceptual summary of table roles mentioned in the available materials, not a validated physical Oracle ERD. Exact table names, constraints, foreign keys, cardinalities, optionality, owners, and dictionary relationships must be checked against Oracle metadata or a DDL-only export. `DICT_REFERENCE` is a logical placeholder for dictionary data, not a confirmed literal table name.

### 3.3 What is needed to produce the physical Oracle schema map

A reliable physical schema and dependency model requires metadata or a DDL-only export (no production data and no credentials), subject to the database account's permissions:

- schema owners and object inventory: `ALL_USERS`, `ALL_OBJECTS`;
- tables and columns: `ALL_TABLES`, `ALL_TAB_COLUMNS`;
- primary/foreign/unique/check constraints: `ALL_CONSTRAINTS`, `ALL_CONS_COLUMNS`;
- views, packages, procedures, functions and triggers: `ALL_VIEWS`, `ALL_SOURCE`, `ALL_TRIGGERS`;
- object dependencies: `ALL_DEPENDENCIES`;
- grants and roles, where permitted: `ALL_TAB_PRIVS`, `ALL_ROLE_PRIVS`.

These views are a collection checklist, not a claim that their contents have already been extracted. A least-privilege metadata export is sufficient; do not provide table rows, personal data, passwords, connection strings, keys, or production secrets.

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
    L_DB <-->|"Batch transfer or removable media<br/>replication details to verify"| R_DB
  end
```

The documentation also specifies two server-placement alternatives: separate application and database servers, or a combined server. A distinct lower-capacity dedicated-server profile is described separately. See [Deployment Architecture](../territory/docs/03-deployment-architecture.md) and [Historical Platform Requirements](../territory/docs/05-platform-requirements.md).

The source does not establish actual regional topology, number of installed instances, replication protocol, conflict-resolution policy, failover nodes, or disaster-recovery arrangements. This is a documented-variants diagram, not a site-specific as-built deployment.

## 5. PPO Territory — external integration landscape

```mermaid
flowchart LR
  APP["PPO Territory<br/>application boundary"]
  IF["External exchange interfaces<br/>technical contracts not verified"]
  APP <--> IF
  IF <--> UIG["ЦБД УИГ<br/>visa / expulsion / deportation data"]
  IF <--> VYB["ПРИУР ГАС «Выборы»<br/>export / form 1.1 РИУР"]
  IF <--> GIAC["ГИАЦ ГУ МВД<br/>responses / Криминал-И / offences"]
  IF <--> ROS["Росстат<br/>forms 12-П and 12-В"]
  IF <--> ZAGS["ЗАГС<br/>birth / death records"]
  IF <--> RP["АС «Российский паспорт»<br/>export path normalization"]
  IF <--> SK["СПО «Сервисный концентратор»<br/>СМЭВ / ЕПГУ / ФНС / ДКС МИД"]
```

The diagram shows seven documented **exchange directions**, not verified live integrations. Protocols, endpoints, authentication, message schemas, ownership of each adapter, and current operational status are not established.

## 6. ARM «Дискриптор» — workstation and hardware/software boundary

```mermaid
flowchart TB
  OP["Operator"]
  subgraph ARM["ARM «Дискриптор» — documented workstation scope"]
    subgraph ST["Stationary station"]
      STUI["Stationary workstation software"]
      STDATA["Stationary-side data / processing"]
    end
    subgraph MOB["Mobile station"]
      MOBUI["Mobile workstation software"]
      MOBDATA["Mobile-side data / processing"]
    end
    EXCHANGE["Data exchange between stations<br/>details follow source specification"]
    HW["Peripheral equipment<br/>keyboard, pointing device, scanner,<br/>printer, laminator and other listed devices"]
    OP --> STUI
    OP --> MOBUI
    STUI --> STDATA
    MOBUI --> MOBDATA
    STDATA <--> EXCHANGE
    EXCHANGE <--> MOBDATA
    HW --- STUI
    HW --- MOBUI
  end
  UNK["Exact component ownership, interfaces,<br/>message formats and deployment constraints<br/>must be verified against the complete specification"]
  EXCHANGE -.-> UNK
```

This is a system decomposition from the ARM description: stationary and mobile stations, user interaction, peripherals, and an exchange boundary. It does not assert a specific network protocol or a particular physical connection for every peripheral.

## 7. Deshifrator — application suite and component architecture

```mermaid
flowchart TB
  subgraph SUITE["Deshifrator application suite"]
    MOBILE["ModuleMobile"]
    STATIONARY["ModuleStationary"]
    PRINT["Printer / PassportPaint"]
  end
  subgraph MOBILEPARTS["Mobile-side responsibilities evidenced in materials"]
    MUI["WPF user interface"]
    SOAP["UMMS SOAP client configuration"]
    FILEOUT["File exchange / removable media"]
    OCR["OCR / MRZ-related processing"]
  end
  subgraph STPARTS["Stationary-side responsibilities evidenced in materials"]
    SUI["WPF user interface"]
    SQLITE["SQLite data access"]
    FIAS["FIAS address search"]
    ELASTIC["Elasticsearch search service"]
  end
  subgraph PRINTPARTS["Printing and document output"]
    LAYOUT["Passport / document layouts"]
    OUTPUT["Print-view / output generation"]
  end
  MOBILE --> MUI
  MOBILE --> SOAP
  MOBILE --> FILEOUT
  MOBILE --> OCR
  STATIONARY --> SUI
  STATIONARY --> SQLITE
  STATIONARY --> FIAS
  FIAS --> ELASTIC
  PRINT --> LAYOUT
  LAYOUT --> OUTPUT
  MOBILE <--> FILEOUT
  FILEOUT <--> STATIONARY
  STATIONARY --> PRINT
```

**Boundary warning.** The relationships above summarize documented suite roles and available package/source observations. They do not establish that every feature is implemented in the same executable, nor do they imply that ARM «Дискриптор» is this application.

## 8. Deshifrator — SQLite data-access component view

```mermaid
flowchart LR
  APP["Application code"]
  CMD["SQLiteCommandEx<T><br/>command execution / result mapping"]
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
  subgraph CLIENT["UMMS client"]
    UI["Client UI / workflow"]
    SEARCH["Person and dossier search"]
    CASE["Case and dossier handling"]
    DOC["Document issue / rollback workflow"]
    LOCAL["Local case and dossier storage"]
    SOAPCLIENT["SOAP client"]
    UI --> SEARCH
    UI --> CASE
    UI --> DOC
    CASE <--> LOCAL
    SEARCH --> SOAPCLIENT
    DOC --> SOAPCLIENT
  end
  SERVICE["UMMS SOAP service"]
  SOAPCLIENT <-->|"SOAP / XML contract"| SERVICE
  SERVICE --> OPS["Operations:<br/>searchPersonFile<br/>getPersonDocuments<br/>getPersonAddresses<br/>getPersonCasesInfo<br/>getDocumentDetail<br/>getAddressDetail<br/>getCountryDictionary<br/>issueNewDocument<br/>rollbackIssueNewDocument"]
```

The operation names are taken from the public API description and source-review notes. Exact SOAP envelopes, namespaces, SOAPAction values, schemas, authentication, error contracts, and endpoint details must be verified against the WSDL and approved integration documentation.

---

## 10. Coverage and remaining verification

| System / area | Architecture views included | Remaining evidence needed |
|---|---|---|
| PPO Territory | Functional domains, conceptual data model, centralized/distributed deployment variants, separate/combined server placement, seven exchange directions | Authoritative list of all 17 modules; complete physical ERD; adapter contracts; actual regional topology; synchronization rules |
| ARM «Дискриптор» | Stationary/mobile workstation decomposition, peripherals, exchange boundary | Full component inventory, hardware mapping, interface/control descriptions, verified data-flow details |
| Deshifrator | ModuleMobile, ModuleStationary, Printer/PassportPaint, SQLite DAL | Complete source tree, project references, executable ownership per feature, full schema and runtime configuration |
| UMMS | Client/service boundary, SOAP operations, search sequence | WSDL/XSD, exact service contract, full client source, deployment and security configuration |
| Supplementary systems | Separate source notes for ARM PPZ/PVK, AS Passport RF and MSKTs | Original covers, version/revision, ownership and any actual integration evidence |

## 11. Evidence and change policy

1. Do not merge separate system boundaries into one runtime architecture without explicit evidence.
2. Do not invent names or responsibilities for the unverified Territory modules.
3. Do not publish production endpoints, credentials, personal data, keys, or real exchange files.
4. Treat modernization ideas as proposals unless a completed implementation is evidenced.
5. Update a diagram only when a source document, code excerpt, schema, test, or deployment artifact supports the change.
