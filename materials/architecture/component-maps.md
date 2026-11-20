# Component maps — detailed architecture views

> Companion to the [canonical architecture catalogue](./README.md) and its [interactive bilingual HTML view](./architecture.html). This file contains 7 detailed Mermaid diagrams. The PPO PAK SQLite data-access diagram is expanded in the [standalone source review](https://ekatmoz88-alt.github.io/github-profile-dashboard-vite/docs/sqlite-data-access-review.html). These diagrams expand the module and component views of the PPO PAK information system and the Dossier Processing Workstation as distinct application boundaries within the same project; UMMS is shown separately where relevant. The diagrams are logical architecture views and do not reconstruct the physical topology of every individual installation. For a separate reconstruction of the supplied Visio and presentation diagrams (including the exact 11/6/5 functional-block inventory, 9/3/4 software-module views, trust-level variants and dossier lifecycle), see [ППО ПАК и АРМ обработки досье — реконструкция по первичным схемам](./PPO PAK-14-source-reconstruction.ru.md).

## 1. Dossier Processing Workstation — architecture and trust boundaries (historical source label: ARM «ППО ПАК»)

```mermaid
flowchart LR
  subgraph VBD["External information environment"]
    DB[("Ведомственная БД / ППО ПАК")]
    GATE["ПОШ ВБД<br/>gateway and consistency checks"]
    DB <--> GATE
  end
  subgraph MOBILE["Mobile module — ПОМС"]
    AUTH["Gateway authentication"]
    SEARCH["Structured search"]
    EXPORT["Dossier import / export"]
    AUTH --> SEARCH --> EXPORT
  end
  subgraph TRANSIT["Transfer boundary"]
    MEDIA[("Removable media")]
    CONTAINER[".ummstr transfer container<br/>internal schema / cryptography to verify"]
    MEDIA --- CONTAINER
  end
  subgraph STATIONARY["Stationary module — ПОСС"]
    IMPORT["Dossier import"]
    EDIT["Dossier editing"]
    PREVIEW["Document preview"]
    PRINT["Printing / MRZ layout"]
    FONT["Font tools"]
    COMPARE["Document comparison"]
    CRYPTO["Transformation / encryption<br/>algorithms and revisions to verify"]
    IMPORT --> EDIT
    EDIT --> PREVIEW --> PRINT
    EDIT --> FONT
    EDIT --> COMPARE
    EDIT --> CRYPTO
  end
  GATE <--> AUTH
  EXPORT --> CONTAINER
  CONTAINER --> IMPORT
  CRYPTO --> CONTAINER
  CONTAINER --> EXPORT
  EXPORT --> GATE
```

The source specification describes three logical zones: external VBD/gateway, mobile module, and stationary module. It also describes removable-media transfer, `.ummstr` files, gateway authentication, dossier search, editing, preview, printing, font tools, comparison, and consistency checks. Exact trust-zone enforcement and cryptographic allocation must be verified against the original technical-project revision and implementation evidence.

### Dossier Processing Workstation — functional areas

```mermaid
flowchart TB
  subgraph ST["ПОСС — stationary software"]
    S1["Information-resource interaction<br/>authentication / requests / translation"]
    S2["Dossier editing<br/>attributes / regulated operations / address data"]
    S3["Document preview and scaling"]
    S4["Printing / character spacing / MRZ / repeat print"]
    S5["Font creation and character parameters"]
    S6["Document comparison<br/>generated vs scanned"]
    S7["Dossier import / export"]
    S8["Transformation and encryption"]
    S9["Authorization-data preparation"]
  end
  subgraph MOB["ПОМС — mobile software"]
    M1["Gateway authentication"]
    M2["Dossier-container import / export"]
    M3["Structured wizard-style search"]
  end
  subgraph GW["ПОШ ВБД — gateway software"]
    G1["VBD interaction / request translation"]
    G2["Consistency validation / conflict checks"]
  end
  M1 --> G1
  M2 <--> S7
  M3 --> G1
  G1 --> G2
```

These are the functional areas enumerated in the specification, not a verified executable/module breakdown. The source describes nine ПОСС areas, three ПОМС areas, and two gateway areas.

## 2. PPO PAK — software component architecture

```mermaid
flowchart TB
  subgraph APP["PPO PAK application layer — documented project structure"]
    COMMON["Common.Data<br/>shared models / providers / interfaces"]
    CORE["Umms.Core<br/>business logic"]
    SERVICE["Umms.Service<br/>service layer / scenarios"]
    USB["Umms.UsbExchange<br/>USB exchange for mobile workstation"]
    CORE --> COMMON
    SERVICE --> CORE
    USB --> COMMON
  end
  subgraph DOMAINS["Documented model areas"]
    PERSON["Persons"]
    DOCUMENT["Documents"]
    CASE["Cases"]
    ADDRESS["Addresses"]
  end
  subgraph DATA["Oracle data model"]
    COREDB[("CORE_* shared entities")]
    DICT["DICT_* reference data"]
    SUBJECT["Subject-area tables<br/>RP / FP / REG / MIG / other"]
  end
  COMMON --> PERSON
  COMMON --> DOCUMENT
  COMMON --> CASE
  COMMON --> ADDRESS
  PERSON --> COREDB
  DOCUMENT --> COREDB
  CASE --> COREDB
  ADDRESS --> COREDB
  COREDB --> DICT
  COREDB --> SUBJECT
```

The project names and model areas come from the published PPO PAK source-code overview. This is a logical view: it does not assert that every project directly connects to Oracle or that the `Umms.*` projects implement the separately documented UMMS SOAP service/client. The Oracle DBMS and table inventory shown here belong to the PPO PAK source context; the independent Oracle DMRS / GLOBAL11 project is separate and is not represented by this diagram.

### PPO PAK — database inventory (Oracle DBMS; not a deployment diagram)

```mermaid
flowchart TB
  DBMS["Oracle DBMS<br/>identified database technology"]
  DBMS --> INV["Reported inventory: 401 tables"]
  INV --> CORE["CORE_* — 44"]
  INV --> DICT["DICT_* — 104"]
  INV --> RP["RP_* — 11"]
  INV --> FP["FP_* — 10"]
  INV --> REG["REG_* — 17"]
  INV --> MIG["MIG_* — 8"]
  INV --> OTHER["Other subject areas — 207"]
  NOTE["Prefix/count inventory only<br/>Schema owners, tablespaces, constraints,<br/>physical storage and instance topology are unknown"]
  INV -.-> NOTE
```

The PPO PAK database overview identifies Oracle as its DBMS and reports 401 tables. A separate physical specification contains 381 numbered entries; the counts come from different source documents and have not been reconciled. This does not refer to the independent Oracle DMRS / GLOBAL11 project. Prefixes are not assumed to be Oracle schema owners. This diagram is a database inventory view, not an ERD and not a deployment view. To build the physical schema map, inspect DDL or permitted Oracle dictionary metadata for owners, objects, columns, constraints, views, PL/SQL units, triggers, and dependencies. Do not use production rows or secrets.

## 3. Dossier Processing Workstation — application suite and shared libraries

```mermaid
flowchart TB
  subgraph APPS["Application components"]
    MOBILE["ModuleMobile"]
    STATIONARY["ModuleStationary"]
    PRINT["Printer / PassportPaint"]
  end
  subgraph SHARED["Shared libraries and layers"]
    COMMON["Common<br/>encryption / file exchange / helpers"]
    MODELS["Common.Data<br/>models and providers"]
    WPF["Common.Wpf<br/>shared WPF controls"]
    DBLAYER["DbStationary.Data<br/>SQLite data access"]
    DBPROV["DbStationary.Providers<br/>stationary data providers"]
    SOAP["ModuleMobile.UmmsClient<br/>SOAP client wrapper"]
  end
  MOBILE --> COMMON
  MOBILE --> MODELS
  MOBILE --> WPF
  MOBILE --> SOAP
  STATIONARY --> COMMON
  STATIONARY --> MODELS
  STATIONARY --> WPF
  STATIONARY --> DBLAYER
  STATIONARY --> DBPROV
  PRINT --> COMMON
  DBPROV --> DBLAYER
```

Component names and relationships are based on the published application-suite review and selected source excerpts. A direct runtime call from ModuleMobile or ModuleStationary to Printer/PassportPaint is not established by the reviewed fragments; this is a project-level grouping, not a verified process-call graph.

### Dossier Processing Workstation — SQLite data-access path

```mermaid
flowchart LR
  APP["Application code"] --> CMD["SQLiteCommandEx<T><br/>command execution / mapping"]
  APP --> PARAM["SQLiteCommandEx_Params<br/>typed parameter helpers"]
  CMD --> FACTORY["ConnectionFactory<br/>shared SQLiteConnection"]
  FACTORY --> DB[("MainDB.db3")]
  CMD --> READER["SQLiteDataReaderEx<br/>column access / ordinal cache"]
  READER --> MAP["SQLiteMaps<br/>row-to-model mapping"]
  MAP --> MODEL["Application models"]
```

## 4. UMMS — client workflow and service operations

```mermaid
flowchart LR
  subgraph CLIENT["UMMS client"]
    UI["Client UI / workflow"]
    SEARCH["Person and dossier search"]
    CASE["Case and dossier handling"]
    ISSUE["Document issue / rollback"]
    LOCAL["Local case and dossier storage"]
    SOAP["SOAP client"]
    UI --> SEARCH
    UI --> CASE
    UI --> ISSUE
    CASE <--> LOCAL
    SEARCH --> SOAP
    ISSUE --> SOAP
  end
  SERVICE["UMMS SOAP service"]
  SOAP <-->|"SOAP / XML contract"| SERVICE
  SERVICE --> OPS["searchPersonFile · getPersonDocuments<br/>getPersonAddresses · getPersonCasesInfo<br/>getDocumentDetail · getAddressDetail<br/>getCountryDictionary<br/>issueNewDocument · rollbackIssueNewDocument"]
```

Exact SOAP envelopes, namespaces, SOAPAction values, schemas, authentication, error contracts, and endpoint details require verification against the WSDL and approved integration documentation.

## 5. Evidence limitations

- The complete authoritative list of the 17 PPO PAK functional modules is not available in the current source set.
- The Dossier Processing Workstation diagrams reflect specified logical functions and trust boundaries; they do not independently prove implementation.
- Dossier Processing Workstation diagrams are limited to the application suite and source excerpts that have been reviewed.
- UMMS API operation names are documented; complete wire-level contracts and deployment details are not included.
- Treat PPO PAK as the umbrella project containing the PPO PAK information system and the Dossier Processing Workstation; retain their distinct application and runtime boundaries. The historical label ARM «ППО ПАК» refers to the Dossier Processing Workstation, not to another project.
- Keep the independent Oracle DMRS / GLOBAL11 project outside the PPO PAK documentation. Do not confuse it with the Oracle DBMS identified in PPO PAK database materials.
- Draw a runtime integration only when primary evidence establishes it.

## 6. PPO ID Docs — documented exchange context and traceability

The following source diagrams preserve the documented exchange and code-to-database relationships from the earlier PPO ID documentation set. They describe documentary evidence, not a verified runtime topology.

### 6.1 Exchange context

```mermaid
flowchart LR
  MS["ПО МС / АРМ МС"]
  DB[("Oracle information database")]
  SERVICE_A["Service participant A"]
  SERVICE_B["Service participant B"]
  USB["Umms.UsbExchange — documented module role"]
  DICT["Dictionary synchronization — documented scenario"]
  MS -->|"Direct SQL calls — documented"| DB
  SERVICE_A ---|"JSON format documented; participants and direction unspecified"| SERVICE_B
  MS --> USB
  USB --> DICT
```

Direct SQL calls from the mobile workstation and JSON-formatted service exchange are stated in the source documentation. The exact service participants, message direction, deployment topology and synchronization implementation are not established by this diagram.

### 6.2 Documented software component inventory

```mermaid
flowchart TB
  subgraph COMPONENTS["Documented software components"]
    DATA["Common.Data — models, providers, data access interfaces"]
    CORE["Umms.Core — business logic"]
    SERVICE["Umms.Service — service layer and scenarios"]
    USB["Umms.UsbExchange — USB exchange for ARM MS"]
  end
  NOTE["Exact dependency graph, process boundaries and deployment are not established"]
  DATA --- CORE
  CORE --- SERVICE
  DATA --- USB
  NOTE -.-> COMPONENTS
```

The component names and roles are documented. The connectors above are only a grouping view; they do not assert a complete dependency graph or direct runtime calls.

### 6.3 API-to-database traceability

```mermaid
flowchart LR
  OP["Documented operation / JSON fields"]
  MODEL["Application model"]
  PROVIDER["Common.Data provider"]
  TABLE["Oracle table mapping"]
  OP -->|"JSON field-to-table mapping described"| TABLE
  MODEL -->|"Model-to-table mapping described"| TABLE
  PROVIDER -->|"Provider table usage described"| TABLE
```

The source materials describe field-to-table, model-to-table and provider-to-table traceability. They do not establish that every operation follows one universal call chain. For table-group classification, see the [editable Draw.io source](../territory-database/database/diagrams/oracle-table-groups.drawio) and [published Oracle table-groups diagram](../territory-database/database/oracle-table-groups.html).
