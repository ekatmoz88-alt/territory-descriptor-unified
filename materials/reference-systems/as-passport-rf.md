# AS «Passport RF» — functional and security architecture notes

## Scope and evidence status

This page structures the supplied description of AS «Passport RF». The source text describes passport accounting, federal database search, information security and replication in an FMS environment. It is not treated as PPO Territory or ARM Descriptor without independent evidence of a shared product boundary.

## Functional subsystems described

### Passport accounting

The subsystem supports:
- attribute-based search of passport registration cards;
- viewing passport information;
- correction of passport data, except series and number, with change history;
- signing corrections with the user's electronic signature;
- recording lost, stolen or surrender-required passports and forms;
- manual registration and automated processing of document formats `888111` and `888222` through an application named Loader.

### Federal database search

At regional level, when the requested passport information is not found in the regional database, the subsystem:
1. sends a request to the federal level;
2. receives the response;
3. presents the result to the user.

### Information security subsystem

The supplied description lists:
- Crypto-Pro cryptographic protection;
- user access-right separation;
- registration of data-import paths;
- terminal registration;
- registration of data loaded into the system;
- printer and report registration;
- certificate management;
- registration of user access actions;
- registration of information-exchange operations.

### Authentication and authorization

The source describes:
- user groups, including system administrator and security administrator;
- password-based login;
- a password validity/change period controlled by the system administrator;
- user password change;
- two-factor authentication using a password and a smart-card digital certificate;
- verification of the presented user certificate against a certificate registered in the database;
- account lockout after three consecutive incorrect-password attempts.

These are specification-level statements. The exact authentication protocol, certificate lifecycle, smart-card middleware, password policy parameters and account-unlock procedure are not included.

### Audit and integrity

The source describes:
- recording security events in special system logs;
- notifying the security administrator;
- automatic reaction to security events;
- notification of suspected unauthorized access;
- account blocking after prohibited actions or repeated failed login attempts;
- use of electronic signatures during data entry, correction and exchange.

The source does not establish log immutability, cryptographic audit chaining, SIEM integration or the precise signature format.

## Data replication description

The supplied source describes an environment with district databases and a central server:
- updated information is automatically transferred to the central server every five minutes;
- once per day, at night, a central data snapshot is replicated back to district servers within the scope permitted for each workstation;
- an administrator of a district server may initiate the reverse replication manually.

This is a separate replication description from the PPO Territory centralized/distributed deployment model. Do not reuse its five-minute or daily schedule for PPO Territory.

The source does not specify transport protocol, conflict resolution, transaction boundaries, replication watermark, failure recovery or data-consistency guarantees.

## Other functional scope mentioned

The source also refers to:
- passport blank logistics and accounting from the Goznak enterprise to territorial FMS units;
- distribution, use and destruction of blank forms;
- accounting documents for blank forms;
- export of information to territorial FMS software complexes;
- a broader public-facing system for address-registration documents and protected electronic interaction.

These functions should be decomposed into separate subsystem documents only after the source document title, system boundary and revision are confirmed.

## Security architecture claims requiring verification

| Source statement | Evidence needed for implementation-level confirmation |
|---|---|
| Crypto-Pro is used | Product/version inventory and approved configuration |
| Two-factor authentication | Authentication sequence, smart-card middleware and tests |
| Electronic signature on corrections | Signature format, certificate validation and verification evidence |
| Three failed logins cause lockout | Configuration and test evidence |
| Access restrictions down to individual records | Authorization model and access-control tests |
| Automatic security response | Event/action mapping and test results |
| Five-minute and daily replication | Job configuration, operational logs and recovery tests |

## Boundary warning

Do not merge this architecture with PPO Territory or ARM Descriptor merely because all materials mention FMS, passports, personal data, Oracle-like databases or exchange. Confirm provenance and actual integration from the original document cover, project name, version, interface contracts and implementation artifacts.
