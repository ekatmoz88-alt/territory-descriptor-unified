# DbStationary — Source and Evidence Register

## Scope

This register identifies the source files available for the static review of the `DbStationary.Data` SQLite layer. It is pinned to repository commit [`9106e0ceccaea4f2175d7d7e74893c6178069372`](https://github.com/ekatmoz88-alt/territory-descriptor-unified/tree/9106e0ceccaea4f2175d7d7e74893c6178069372).

A file being present proves only that the selected source text is available for inspection. It does not prove that the complete application builds, that the file belongs to the deployed binary, or that the described behavior was observed at runtime.

## Published source set

| Evidence ID | Source file | Blob SHA | What it supports |
| --- | --- | --- | --- |
| DBS-SRC-001 | [`ConnectionFactory.cs`](../sources/DbStationary.Data/ConnectionFactory.cs) | `2ea039820b57a9a3d705a8b7f1858e7350e26563` | Connection-string construction, factory singleton field, connection creation/opening and returned connection reference. |
| DBS-SRC-002 | [`SQLiteCommandEx.cs`](../sources/DbStationary.Data/SQLiteCommandEx.cs) | `06e2d4f7bc6d544ca8c6c97c6399921218a45b38` | Command creation, execution overloads, command disposal scopes, reader lifetime, parameter reassignment and NULL helper. |
| DBS-SRC-003 | [`SQLiteCommandEx_Params.cs`](../sources/DbStationary.Data/SQLiteCommandEx_Params.cs) | `1f5c0eacac989ef46de3d76ad7728afe6cd96023` | Parameter construction and typed helper methods, including GUID parameters. |
| DBS-SRC-004 | [`SQLiteDataReaderEx.cs`](../sources/DbStationary.Data/SQLiteDataReaderEx.cs) | `f22f9dd94478e1bffc771ed2a9bce7614e6be70e` | Column ordinal cache, typed getters, generic cast and NULL handling. |
| DBS-SRC-005 | [`SQLiteMaps.cs`](../sources/DbStationary.Data/SQLiteMaps.cs) | `9d842bd597d06c26f9bf3709930a59d8fe49d119` | Reader-to-model mapping, expected string representation for `CaseGUID`, and mapping of fields named `Login`, `Password` and `RoleCode`. |

## Claim-to-evidence mapping

| Claim ID | Claim | Evidence | Status | Limitation |
| --- | --- | --- | --- | --- |
| DBS-CLM-001 | The factory stores one connection in a static factory instance and returns that connection. | DBS-SRC-001, lines 11–33 | Source-based | Does not prove concurrent use or runtime thread-safety. |
| DBS-CLM-002 | The factory constructor opens the connection; the class exposes no close/dispose method. | DBS-SRC-001, lines 18–33 | Source-based | Cleanup by external callers is outside the file. |
| DBS-CLM-003 | Command lifetime differs between parameterless and parameter-array execution overloads. | DBS-SRC-002, lines 92–280 | Source-based | Caller impact requires tests and call-site review. |
| DBS-CLM-004 | `AsDataReader()` returns a reader from inside its own `using` scope. | DBS-SRC-002, lines 220–228 | Source-based; defect follows from scope | Runtime test not performed. |
| DBS-CLM-005 | Parameter count is guarded by `Debug.Assert` before positional assignment. | DBS-SRC-002, lines 286–293 | Source-based | Release configuration and caller behavior not tested. |
| DBS-CLM-006 | `GetStringNullable()` maps database NULL to an empty string. | DBS-SRC-004, lines 58–64 | Source-based | Domain impact is unknown. |
| DBS-CLM-007 | `CaseModelMap` expects a string value for `CaseGUID` and parses it with `Guid.Parse`. | DBS-SRC-005, lines 24–41 | Source-based | Does not prove the database's actual stored values or complete persistence path. |
| DBS-CLM-008 | `UserModelMap` maps fields named `Login`, `Password` and `RoleCode`. | DBS-SRC-005, lines 15–22 | Source-based | Does not prove actual credentials or password storage format. |

## Evidence gaps

| Gap ID | Missing evidence | Why it matters | Status |
| --- | --- | --- | --- |
| DBS-GAP-001 | Provider source, including `CaseProvider.cs` | Needed to verify transaction call sites, SQL usage, parameterized queries and provider-level error handling. | Evidence required |
| DBS-GAP-002 | `MainDB.db3` or a verified `sqlite_schema` / DDL export | Needed to verify table names, column types, constraints and stored GUID/date representations. | Evidence required |
| DBS-GAP-003 | Model class definitions and related libraries | Needed to verify mapping compatibility and nullability expectations. | Evidence required |
| DBS-GAP-004 | `.sln`, `.csproj`, dependency versions and build output | Needed to reproduce compilation and identify the exact application target. | Evidence required |
| DBS-GAP-005 | Focused automated tests or recorded runtime traces | Needed to validate disposal, concurrency, parameter reuse, conversion and GUID round trips. | Evidence required |
| DBS-GAP-006 | Complete source tree and configuration inventory | Needed for a full application-level audit and security review. | Evidence required |

## Review rules

- Keep requirements, source observations, inferred risks and runtime findings separate.
- Pin every source-based claim to a file and source revision.
- Use direct source links in the sentence that the source supports.
- Use cross-references when the same evidence supports more than one section; do not duplicate the same explanation.
- Do not describe a risk as a demonstrated runtime failure without test evidence.
- Keep the original source archive separate from the selected public evidence set.
- Do not publish real credentials, personal data, private keys or production connection details.

## Review status

- Source inventory: **Verified for the five files listed above at the pinned commit**.
- Static source review: **Source-based**.
- Provider-level review: **Evidence required**.
- Database/schema verification: **Evidence required**.
- Build and runtime verification: **Not verified**.
- PII/security review of all repository materials: **Pending**.
