# Data Exchange, Administration and Technical Identity Records

> **Status:** analytical description of a historical operations-documentation excerpt. This is not a verified description of the current implementation.
>
> **Attribution:** the excerpt describes software with a database, a system directory, export files and a `LOG` directory. Until the document cover and version are checked, it must not be attributed unconditionally to a specific product or PPO Territory release.
>
> **Evidence boundary:** directly documented behaviour, architectural interpretation and items requiring source-code verification are distinguished below.

## 1. General information-exchange model

The document distinguishes two file types:

| Type | Purpose | Representation |
|---|---|---|
| Data export | Transfer field values between information systems for machine processing | Agreed text format |
| Text response | Present query results to a user, primarily for viewing and printing | Human-readable file |

The distinction matters: an export is an exchange artefact, whereas a text response is a user-facing representation of a result. Their formats and lifecycles should not be conflated without further evidence.

A request is made to the relevant database or reference-information system to obtain an export or text response. The document identifies transfer risks including accidental corruption or loss, deliberate modification, unauthorised viewing and unauthorised access to the means used to retrieve information.

### 1.1. Protection of internal exports

For internal exports in the system's own format, the document specifies two successive operations:
1. encoding the transferred information to protect it from viewing and modification;
2. additional archiving with a built-in compression algorithm to reduce the amount of data transferred.

The source term “encoding” does not identify a cryptographic algorithm or unambiguously establish that encryption is meant. Do not claim AES, GOST, digital signatures, message authentication or a specific compression algorithm until the implementation is inspected.

## 2. Export process

The document describes three stages:

1. **Find updated information** in database tables. In network mode, access by other users to the table being processed is temporarily blocked.
2. **Optimise the data set** to eliminate duplicate rows.
3. **Generate the export file.** This operation can place a significant load on the local network, although database work remains possible.

### 2.1. Architectural notes

- The lock is described in connection with the table being processed during the search for updated data. Without source code, this must not be generalised to a lock on the entire database or the entire export process.
- Duplicate-row elimination is mentioned as a data optimisation step; the row-equivalence criteria are not specified.
- The incremental-export marker, transaction boundaries, retry strategy and behaviour after a failure between stages are not described.
- No bandwidth limits or network-throttling mechanism are specified.

## 3. Data import process

The document specifies the following rules:

- data is loaded from the system directory;
- each file is checked for integrity before processing;
- corrupted files remain in the directory;
- a log file with the same name is created in the directory during loading;
- the marker tells other handlers that the corresponding file is already being processed and prevents them from starting a concurrent load of that file.

### 3.1. Interpretation of the locking mechanism

The described marker can be classified as a file lock or busy marker. It does not prove the existence of a distributed queue, an atomic transaction or an exactly-once guarantee.

Implementation documentation should verify:
- whether marker creation is atomic;
- how the marker is named and associated with the input file;
- whether it is removed on success, failure and abnormal termination;
- how stale markers are handled;
- how concurrent access to the directory is controlled;
- how corrupted and previously processed files are retried;
- how the outcome is recorded and successful files are moved or archived.

## 4. Import of third-party data formats

For third-party formats, the document specifies the minimum personal identity data required to identify an individual:

- surname;
- first name;
- patronymic;
- date of birth;
- place of birth.

This is a minimum set of input attributes for a matching procedure, not proof of unique identification. Normalisation, incomplete names, collisions, name changes, spelling variants and manual resolution of ambiguous matches are not described.

## 5. Administration and access rights

The document describes individual user permissions. Permission data is stored in a separate file in the application directory; users with administrative privileges may change permissions.

The following functional permissions are listed:

| Permission in the source | Scope |
|---|---|
| Create new people | Create a person record; if denied, a request to the central database is required first |
| Enter Russian dossier data | Enter domestic Russian dossier data; printing is separately controlled |
| Modify dossier data | Change dossier-status markers |
| Enter international passport data | Enter the application and international passport dossier data; printing is separately controlled |
| Modify an international passport record | Change approval dates, archive numbers, child details and dossier status |
| Address bureau | Enter arrival/departure slip information |
| Modify an address record | Enter arrival and departure dates in an address record |
| Print documents | Print dossier forms and citizenship certificates |
| Citizenship | Access the citizenship card index interface |
| Administrator capabilities | Manage other users' permissions |
| Delete data | Delete records within permitted accounting areas |
| Delete technical data | Delete technical links between old and new identity data |
| View technical data | View technical information |
| Access restricted information | Privileged access to protected person records |
| View request statistics | View operations and completed queries |
| Statistical processing | Run statistical processing |
| Query builder | Access the query-construction interface |
| Allow import | Receive incoming data |
| Allow export | Run the data-export function |

### 5.1. Authorisation model: known and unknown properties

The document explicitly describes user permissions assigned separately for functional operations. This can be represented as a historical fine-grained access-permission model.

However, storing permissions in a separate file and providing an administration menu do not, by themselves, prove:
- role-based access control (RBAC);
- role inheritance;
- centralised identity management;
- multi-factor authentication;
- cryptographic protection of the permission file;
- server-side enforcement of every permission.

These properties require separate evidence.

## 6. Operational logging

The application writes error messages and the following operational events to files in the `LOG` directory:

1. user login to the database and session termination;
2. received-file details: file name, record count and processing speed;
3. detected database corruption;
4. export details: file names and record counts.

The document does not specify the record format, time zone, timestamp precision, user identifier in each record, tamper protection, retention period or centralised collection.

The accurate description is therefore “file-based logging of the listed events”. Do not call it immutable audit logging or a full SIEM system without verification.

## 7. Technical records and changes to identity data

The document describes automatic algorithms for changing a person's identity data. These algorithms create:
- special signal records for the automatic processor;
- technical records/links connecting old identity data to new identity data.

According to the description:
- ordinary users do not see technical signals intended for automated processing by default;
- technical records can be viewed, but deletion is restricted;
- when a user opens a technical record, the application automatically redirects them to the current data;
- a user with the relevant technical-data viewing and deletion permissions can delete a technical record in data-entry mode.

### 7.1. Architectural interpretation

The mechanism can be described as a separate identity-resolution and redirection layer from obsolete identity data to the current record. It may be related to:
- duplicate detection and person matching;
- preservation of identity-attribute change history;
- redirecting references from old records;
- preventing broken relationships when identity data changes.

Do not automatically equate a technical record with a person-merge table, a master-person record or a full master data management (MDM) system. That would require comparison with database tables, keys, import algorithms and the code that redirects users to the current record.

## 8. Network administration

The document states that the network server is configured once and, if installation is correct, does not require ongoing attention. When creating user groups and assigning permissions, it specifically emphasises:
- correctly restricting access to files and directories;
- granting access to protected resources only to authorised users;
- ensuring that such users have passwords.

This is an operational instruction from a historical document, not a description of a specific network-authentication model or current server configuration.

## 9. Evidence matrix

| Statement | Source | Status |
|---|---|---|
| Machine-readable exports and text responses are distinct | Historical documentation, general exchange principles | Documented |
| Internal exports are encoded and compressed | Same section | Documented; algorithms not identified |
| Export has three stages | Section 3.2 | Documented |
| The table being processed is temporarily locked during the update search | Section 3.2 | Documented |
| A same-name marker prevents concurrent processing of a file | Section 3.3 | Documented |
| Corrupted files remain in the directory | Section 3.3 | Documented |
| User permissions are stored in a separate file | Section 4.1 | Documented |
| Listed events are written to the LOG directory | Section 4.2 | Documented |
| Technical records link old and new identity data | Section 5 | Documented |
| AES/GOST or digital signatures are used | Not specified | Not established |
| Exactly-once delivery is guaranteed | Not specified | Not established |
| Permissions are implemented through RBAC | Not established | Requires verification |
| LOG is immutable audit storage | Not established | Not established |

## 10. Source-code and operational checks

1. Exporter: updated-record selection, table locks, deduplication and file generation.
2. Importer: integrity validation, file marker, marker cleanup, retries and crash recovery.
3. Export format: encoding, structure, schema version, compression and cryptographic protection.
4. Permission file: format, secret storage, permission enforcement and administrative operations.
5. Logging: record fields, tamper protection, rotation and retention.
6. Technical records: table schema, link creation/deletion rules and redirection to the current record.
7. Network directories: ACLs, accounts, availability, backups and write permissions.

## 11. Conclusion

The historical excerpt describes a file-based exchange mechanism between databases: separate machine-readable export and human-readable response formats, a three-stage export process, integrity checks for incoming files and a file marker that prevents concurrent loading of the same file.

It separately describes fine-grained user permissions, file-based logging in the `LOG` directory and technical records used to link a person's old and new identity data.

These details provide a basis for **Data Exchange**, **Access Control**, **Operational Logging** and **Identity Resolution** documentation. Until the document cover, version, source code and database schema are verified, they should remain classified as historical documentation findings rather than being attributed automatically to a specific modern implementation.
