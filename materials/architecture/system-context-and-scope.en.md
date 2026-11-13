# System Context and Architecture Boundaries: PPO Territory and Deshifrator

> **Status:** historical documentation and analytical synthesis of real deployed systems. The systems were deployed and operated in server environments, including office infrastructure. This document is a logical architecture view, not a reconstruction of the physical topology of a specific installation.
>
> **Source:** software documentation ID 53281996.425530.9-4757-3.ПЗ.01.0.01, including the annotation and architecture description, pages 5–26. Source-code implementation requires separate verification.

## 1. Purpose and scope

This document establishes the context of two distinct subjects described in the same set of historical materials:

- **PPO Territory** — a modular departmental information system described as a web application with a client web interface, an application server and a database server.
- **Deshifrator** — a specialised document-processing workstation system whose historical annotation uses the earlier label ARM Descriptor / «Дискриптор» and identifies two software stations: a stationary station (ПО СС) and a mobile station (ПО МС).

Their shared business domain and appearance in the same documentation set do **not** prove that they are one executable product, share a runtime, or that all ARM components are part of PPO Territory.

## 2. System context and boundaries

### 2.1. PPO Territory

The documentation describes PPO Territory as a modular solution for automating the work of territorial units of the Russian Federal Migration Service (FMS). Its functional scope includes document processing and accounting, person and organisation records, address data, case management, migration and registration accounting, citizenship workflows, administrative proceedings, reporting and external information exchange.

PPO Territory is described as a web application. That statement belongs to the PPO Territory section of the source document; it must not automatically be applied to Deshifrator's stationary and mobile software stations.

### 2.2. Deshifrator

The annotation describes Deshifrator as a C# program and identifies two stations:

| Component | Abbreviation | Description in the annotation |
|---|---|---|
| Stationary station software | ПО СС | Workstation for document preparation and processing |
| Mobile station software | ПО МС | Mobile workstation involved in processing and transferring results |

The annotation lists the following ARM capabilities:
- preparing documents with machine-readable zones;
- generating and printing documents;
- editing and deleting document-history records;
- working with document history, including earlier documents;
- using dossier information to populate document data;
- selecting a font and typeface based on a reference sample;
- transferring prepared accounting data through the mobile station.

These are capabilities stated in the historical annotation. They do not prove that every capability has been located in the available source-code version or tested.

### 2.3. Ambiguity in the web-application statement

The Deshifrator annotation also says that the system operates “as a web application through a browser”. The same context describes the workstation as a C# program consisting of two stations. Without the complete software-implementation section and the original projects, it is not possible to determine whether the browser statement refers to Deshifrator itself, PPO Territory, or the wider operating environment.

**Documentation rule:** do not label ПО СС and ПО МС as browser clients or place them inside PPO Territory's three-tier web diagram until primary documentation or source code confirms that interpretation.

## 3. PPO Territory functional architecture

### 3.1. Functional modules and subject areas

The source lists the following areas:

- Russian national passport;
- registration accounting for Russian citizens;
- international passports;
- invitations for foreign nationals;
- visas;
- migration registration;
- temporary residence permits;
- residence permits;
- citizenship;
- asylum and refugee status;
- labour migration;
- revenue administration;
- blank-form accounting;
- migration cards;
- address-reference services;
- dossiers;
- administrative proceedings.

Some sections also mention complaint handling. Lists and groupings may differ across sections of the source document. This list should therefore be treated as a **catalogue of named subject areas**, not as a final verified inventory of a fixed number of modules.

### 3.2. Service subsystems

The documentation names:
- administration;
- regulatory and reference data management (НСИ);
- external information exchange;
- personal-data protection for designated categories of individuals;
- an employee personal cabinet;
- signal processing;
- system monitoring.

Guaranteed message delivery is stated as a capability of the external-exchange subsystem. The reviewed excerpt does not specify transport protocols, queues, retry policies or deduplication mechanisms.

### 3.3. System-wide mechanisms

The system layer includes:
- searching and accounting for individuals, legal entities, documents and addresses;
- identity matching and record resolution;
- displaying signals and the case journal;
- correcting core records and case attributes;
- closing cases, returning them for rework and cancelling them;
- streaming data entry;
- maintaining historical addresses;
- using address-reference data and tax-authority codes.

These mechanisms should be treated as shared system services. The exact allocation of responsibilities among server-side modules requires implementation evidence.

## 4. PPO Territory logical architecture

The software documentation explicitly specifies a three-tier architecture:

| Tier | Component | Responsibility |
|---|---|---|
| Client | Web interface | Information presentation and user interaction |
| Application | Application server | Request processing and application logic |
| Data | Database server | Data storage and processing |

~~~mermaid
flowchart TB
  USER[User]
  WEB[Client web interface]
  APP[PPO Territory application server]
  DB[(Database server)]
  USER --> WEB --> APP --> DB
~~~

The document allows two server-placement alternatives:
1. the application server and database server are hosted separately;
2. the application server and database server are hosted together.

The excerpt does not identify the specific web-server technology, server runtime, DBMS, load-balancing approach or high-availability design.

## 5. Deployment modes

### 5.1. Centralised mode

The centralised mode is intended for offices with permanent, high-speed connections to the regional application server. Staff access the system remotely through a thin client.

~~~mermaid
flowchart TB
  subgraph REGION[Regional environment]
    APP[Regional application server]
    DB[(Database server)]
    APP --> DB
  end
  subgraph OFFICES[Territorial offices]
    C1[Thin client · office A]
    C2[Thin client · office B]
    C3[Thin client · office C]
  end
  C1 --> APP
  C2 --> APP
  C3 --> APP
~~~

This is a logical view of the documented mode, not the configuration of a specific region.

### 5.2. Distributed mode

The distributed mode is intended for regions where some offices lack stable or sufficiently high-performance communication links. Offices with permanent high-speed connectivity continue to access the regional server through a thin client.

The supplied excerpt ends at the beginning of the description of offices with unstable connectivity. It therefore does not establish:
- which components are installed locally;
- whether a local database is used;
- how and when changes are transferred;
- whether batch exchange or removable media is used;
- how conflicts and message retries are handled;
- which operations are available offline.

Until the rest of the source section is available, distributed mode should be described only as a **documented operating option**, without inventing its synchronisation mechanism.

## 6. Integrations and information exchange

The functional description lists external exchanges, including retrieval of signal lists, information about lost or stolen documents, organisation data and control lists, as well as exchanges with regional and federal information systems. Interaction with GISMU and regulatory/reference-data exchange are also mentioned.

This evidence establishes integration requirements and named exchange directions, but it does not define the current status, endpoint, protocol, message format, authentication method, interface owner or delivery guarantees for each specific implementation.

### 6.1. UMMS SOAP integration boundary

Separately inspected client-side source materials contain a UMMS SOAP client with operations for searching and retrieving information and submitting data in selected workflows.

This confirms a specific SOAP interface in the inspected client component. It does **not** prove that PPO Territory as a whole is SOAP-based or that this service is the internal API of the three-tier web application.

## 7. Data, security and audit requirements

The historical documentation lists cross-cutting requirements for:
- user identification, authentication and authorisation;
- role-based access control;
- logging user actions and system operations;
- auditing dossier access and personal-data operations;
- recording printing and export;
- recording the grounds and reasons for data corrections;
- integrity controls and duplicate detection;
- change-history management;
- backup and recovery;
- management of users, roles and reference data.

These are requirements stated in a historical document. They are not, by themselves, evidence that a particular software version complies with current legislation or modern information-security standards. Implementation claims require source code, configuration, operational documentation and test results.

## 8. Technology statements and interpretation limits

The annotation states that ARM was developed in C#, that Microsoft Visual Studio 2013 was used, and mentions TFS (Team Foundation Server) in wording that associates it with interface development.

The last statement requires editorial clarification: Team Foundation Server is generally associated with source control, work-item tracking and build management (ALM/DevOps), rather than being a user-interface technology.

The reference to Visual Studio 2013 does not establish the exact .NET Framework version. That must be determined from the original project files: TargetFrameworkVersion, TargetFramework, ProjectTypeGuids, assembly references, NuGet dependencies and build configuration.

## 9. Evidence matrix

| Statement | Basis | Status |
|---|---|---|
| PPO Territory is a modular system | Software documentation | Documented |
| PPO Territory has three tiers | Architecture description | Documented |
| Centralised and distributed modes are supported | Operational description | Documented; distributed-mode details are incomplete |
| Deshifrator includes ПО СС and ПО МС | Deshifrator annotation | Documented |
| Deshifrator was developed in C# | Deshifrator annotation | Documented |
| Deshifrator is entirely a web application | Ambiguous annotation wording | Requires verification |
| All listed functions are implemented in the available source code | Full traceability has not been completed | Not established |
| A specific client component uses UMMS SOAP | Inspected source code | Confirmed for that component |
| SOAP is the common API of PPO Territory | No direct evidence | Not established |
| The physical topology of a specific region is known | Not present in the supplied excerpt | Unknown |

## 10. Evidence needed for a technical architecture

Moving from a logical model to a technical architecture requires:
1. original .csproj files for ПО СС, ПО МС and shared libraries;
2. configuration files and launch parameters;
3. station-to-station exchange implementation and exchange-file formats;
4. integration-client and server-adapter source code;
5. data models, DDL and DBMS metadata;
6. the remainder of the historical distributed-mode section;
7. installation and configuration instructions for regional and local components;
8. a requirements traceability matrix and test evidence.

## 11. Conclusion

The historical documentation presents PPO Territory as a modular web system with a three-tier architecture and two operating modes: centralised and distributed.

Deshifrator is described separately as a specialised document-processing workstation system with mobile and stationary stations. The browser-based statement in its annotation is ambiguous and must not replace verification of the actual project architecture.

Reliable technical documentation must preserve system boundaries and distinguish documented requirements, source-code findings, analytical reconstructions and unknown implementation details.
