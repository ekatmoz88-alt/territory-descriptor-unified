# PPO Territory — Deployment Architecture

## Evidence status

This document consolidates the deployment and infrastructure requirements stated in the supplied PPO Territory operational material. It describes supported/documented deployment variants, not the verified configuration of a particular region or installation.

## Two independent architecture dimensions

The source distinguishes:

1. **Server placement:** separate application and database servers, or a combined application/database server.
2. **Operating mode:** centralized or distributed.

These dimensions must not be conflated. A combined server is a placement choice; centralized/distributed describes how regional and territorial installations are organized and exchange data.

## Centralized operating mode

- Territorial offices in a region have permanent, high-performance communication links to the regional application server.
- One PPO Territory instance is installed for the region.
- Offices use the regional application remotely through a thin client.

## Distributed operating mode

- Offices with stable high-speed connectivity use the regional application through a thin client.
- Offices with intermittent, low-performance or unavailable connectivity have a local application server and local database server.
- Users in those offices work through a thin client over the local network.
- Data replication/exchange between territorial installations and the regional installation is supported by batch data transfer or removable media.

The source does not specify the replication protocol, schedule, directionality, conflict-resolution policy, master-record rules, retry semantics, or consistency guarantees. These must remain open verification items.

## Server placement variants

### Separate application and database servers

**Database server**
- CPU: 2.4 GHz, `4 core-x1` (source notation retained; exact interpretation is not established).
- RAM: 12 GB.
- HDD: 2 TB, RAID 10 and RAID 1.
- OS: Oracle Enterprise Linux 5.6, 64-bit.

**Application server**
- CPU: 2.4 GHz, `4 core-x2` (source notation retained; exact interpretation is not established).
- RAM: 24 GB.
- HDD: 1 TB, RAID 1.
- OS: Debian 6, 64-bit.

### Combined application and database server

- CPU: 2.4 GHz, `6 core-x2` (source notation retained; exact interpretation is not established).
- RAM: 24 GB.
- HDD: 2 TB, two RAID arrays at levels 1 and 10.
- OS: Oracle Enterprise Linux 5.6, 64-bit.

### Separately described dedicated-server profile

The same source also gives a distinct dedicated-server profile with combined application and database roles:

- Intel Core 2 Duo E7200 or higher.
- RAM: 4 GB.
- At least 10 GB free disk space.
- Oracle Enterprise Linux 5.6, 64-bit.

This profile is not merged with the higher-capacity combined-server specification. The intended scale, workload and relationship between these two profiles are not explained.

## Network bandwidth requirements

The source gives historical bandwidth thresholds based on daily case volume:

| Daily cases | Stated minimum link bandwidth |
|---:|---:|
| Up to 50 | 256 Kbit/s |
| 50–100 | 512 Kbit/s |
| More than 100 | 1 Mbit/s |

These are historical source requirements, not current sizing advice. Concurrent users, payload sizes, latency, peak traffic, compression ratio and test methodology are not provided.

## Client workstation and software requirements

The historical workstation profile is:
- Intel Pentium 4 or faster.
- At least 512 MB RAM.
- At least 1 GB free disk space.
- Windows XP, Vista, 7 or 8.
- Google Chrome 19 or later.
- MS Word and Excel, or a freely distributed equivalent.
- DLL files for the special printer.
- Java Runtime Environment 6.
- CryptoPro CSP 3.6 R2.

These versions are obsolete and must not be presented as modern deployment recommendations.

## Operational boundaries

The supplied materials also describe:
- setup and configuration of server software and PPO Territory;
- creation of user and organizational-unit accounts;
- configuration of client workstations and application-level access;
- ensuring full application startup;
- administrator and user consultations;
- installation of published updates;
- regular operational support;
- regular checks of backup-system operation.

The actual installation topology, backup product, backup schedule, retention, restore testing, recovery objectives and regional host inventory remain unverified.

## Related documents

- [Infrastructure and platform requirements](05-platform-requirements.md)
- [Lifecycle, updates and operational support](06-lifecycle-testing.md)
- [Architecture catalogue](../../architecture/README.md)

## Verification gaps

- Regional and territorial server inventory and actual deployment.
- Exact meaning of CPU notation `core-x1` / `core-x2`.
- Replication implementation and conflict handling.
- Network latency and throughput acceptance criteria.
- Backup/restore procedures, RPO/RTO and restore-test evidence.
- Exact purpose of the low-capacity dedicated-server profile.
