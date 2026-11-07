# ARM Descriptor — System Design

## Context

ARM Descriptor is an automated document-processing workstation comprising a stationary station and a mobile station. Its documented external context includes PPO Territory and the VBD gateway software (ПОШ ВБД).

## Logical components

- **PPO Territory / VBD:** external departmental information system and data source.
- **ПОШ ВБД:** gateway mediating requests to the departmental database and described consistency checks.
- **ПОМС:** mobile-station software for gateway authentication, search and dossier transfer preparation.
- **ПОСС:** stationary-station software for dossier processing and document preparation.
- **Removable media:** transfer boundary between mobile and stationary stations.

## Data flow

1. ПОМС communicates with ПОШ ВБД and searches the external data source.
2. Selected dossier data is exported into a transfer container.
3. The container is moved to ПОСС using removable media.
4. ПОСС processes the dossier and prepares a return package.
5. The return package is transferred to ПОМС and submitted through the gateway.

## Transport and cryptography

The technical materials mention HTTP/HTTPS and AES/GOST mechanisms. Transport protocols, database query translation and file-container encryption are separate concerns. HTTP(S) does not establish that SQL is transmitted directly over HTTP. Exact cryptographic allocation must be checked against the relevant technical-project revision and implementation evidence.

This page describes documented logical design, not proof that every specified mechanism was implemented in a particular build.
