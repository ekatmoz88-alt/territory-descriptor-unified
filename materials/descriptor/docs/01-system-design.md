# ARM Descriptor — System Design and Logical Architecture

## Context

ARM Descriptor is an automated document-processing workstation comprising a stationary station and a mobile station. Its documented external context includes the departmental database (ВБД), PPO Territory as the named departmental information environment in the supplied materials, and gateway software (ПОШ ВБД).

The workstation complex and the external information system are kept as separate architecture boundaries. This document does not assert that every named external system is one deployed product or that every described interface was implemented in a specific build.

## Main subsystems

The ARM is described as two cooperating subsystems:

1. **Stationary station (ПОСС).**
2. **Mobile station (ПОМС).**

The broader functional description groups the software into:
- data pre-processing and event generation;
- data collection;
- interaction with external information systems.

These are functional groupings from the source, not necessarily separate executables or deployable services.

## ПОСС — stationary-station software components

The supplied specification lists:
- interaction with stationary-station information resources;
- dossier editing;
- document preview;
- document printing;
- font processing;
- comparison of generated and scanned documents;
- dossier import/export to and from the mobile station;
- data transformation for mobile/stationary exchange;
- preparation of data for ПОМС authorization.

## ПОМС — mobile-station software components

The mobile-station description includes:
- gateway authentication;
- dossier search using structured filters;
- dossier selection and export;
- import/export of dossier data;
- connection to ПОШ ВБД.

The exact executable and library boundaries require comparison with the source solution and deployment package.

## ПОШ ВБД — gateway role

The gateway mediates the mobile station's interaction with the departmental database. The technical requirements describe request translation, access to current reference data and consistency checking. The precise internal component inventory and protocol contracts are not fully specified in the supplied text.

## Workstation hardware and peripherals

The station equipment list includes:
- stationary document-processing workstation and its software;
- printer for document forms;
- scanner;
- uninterruptible power supply;
- laminator;
- monochrome laser printer with duplex unit;
- inkjet printer;
- machine-readable-zone recognition module;
- contactless card/document module;
- contact-card module;
- mobile station and its software;
- mobile floor-standing air conditioner.

The source does not provide exact device models, driver versions, interface standards or a one-to-one mapping of every peripheral to a software module.

## High-level data flow

1. ПОМС connects to ПОШ ВБД and searches the departmental database.
2. The user selects dossier data for processing at ПОСС.
3. ПОМС transforms the selected data into a transfer representation.
4. The file is moved through registered removable media to ПОСС.
5. ПОСС imports and transforms the file into editable dossier data.
6. The stationary user edits the dossier; changes are recorded in a log.
7. ПОСС exports the original dossier and change log back to ПОМС.
8. ПОМС compares the current VBD source data with the exported baseline.
9. If the source data is unchanged, the changes are submitted; otherwise import is aborted.

See [Data Exchange, Transfer Workflow and Formats](04-data-exchange.md) for the detailed sequence and open questions.

## Security and trust boundaries

The supplied security architecture describes separate trusted stationary and departmental database environments, with the mobile station treated as a transit/untrusted environment. Exchange between mobile and stationary stations is described as physical transfer using registered removable media. The exact trust-zone enforcement, cryptographic implementation and operational controls must be verified against the original technical-project revision and implementation evidence.

See [Trust Levels and Security Architecture](07-trust-levels-security-architecture.md).

## Separate systems and unrelated source fragments

The supplied material also contains descriptions of ARM PPZ/PVK browser troubleshooting, the MSKTs well-cementing measurement station, and AS Passport RF. These are not components of ARM Descriptor and are documented separately in the repository's supplementary source-material catalogue. Their appearance in the same source bundle does not establish integration.

## Evidence limitations

- Functional module lists are specification-level evidence, not proof of implementation.
- Hardware inventory does not identify actual installed devices.
- No exact protocol or physical topology is inferred beyond the documented removable-media workflow.
- The relationship between ПОМС/ПОСС and similarly named software projects must be verified against source and deployment artifacts.
