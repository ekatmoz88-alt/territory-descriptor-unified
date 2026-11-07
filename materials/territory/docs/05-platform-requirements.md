# PPO Territory — Historical Platform and Infrastructure Requirements

## Source status

The values below are transcribed from supplied historical operational documentation. They describe stated requirements, not proof that every regional installation used the same configuration. The listed operating systems and runtimes are obsolete and must not be treated as current security or sizing recommendations.

## Server profiles

| Role / profile | CPU | RAM | Storage | Operating system |
|---|---|---:|---|---|
| Separate database server | 2.4 GHz, `4 core-x1` | 12 GB | 2 TB, RAID 10 and RAID 1 | Oracle Enterprise Linux 5.6, 64-bit |
| Separate application server | 2.4 GHz, `4 core-x2` | 24 GB | 1 TB, RAID 1 | Debian 6, 64-bit |
| Combined application and database server | 2.4 GHz, `6 core-x2` | 24 GB | 2 TB, two RAID arrays, levels 1 and 10 | Oracle Enterprise Linux 5.6, 64-bit |
| Dedicated combined server, separately described | Intel Core 2 Duo E7200 or higher | 4 GB | At least 10 GB free | Oracle Enterprise Linux 5.6, 64-bit |

The notation `4 core-x1` and `6 core-x2` is preserved from the source. It is ambiguous and must not be converted into a physical-core or socket count without the original hardware specification. The low-capacity dedicated-server profile is kept separate from the higher-capacity combined-server profile because the source does not explain their relationship or intended workload.

## User workstation

- CPU: Intel Pentium 4 or faster.
- RAM: at least 512 MB.
- Free disk space: at least 1 GB.

## User workstation software

- Operating system: MS Windows XP, Vista, Windows 7 or Windows 8.
- Browser: Google Chrome version 19 or later.
- Office software: MS Word and MS Excel, or a freely distributed equivalent.
- Special printer DLL files.
- Java Runtime Environment 6.
- CryptoPro CSP 3.6 R2.

## Network bandwidth

| Daily case volume | Stated minimum bandwidth |
|---:|---:|
| Up to 50 | 256 Kbit/s |
| 50–100 | 512 Kbit/s |
| More than 100 | 1 Mbit/s |

The source does not provide concurrent-user counts, average or peak payload sizes, latency limits, availability targets, or load-test methodology. These thresholds therefore cannot be used as a complete capacity-planning model.

## Historical technology warning

Oracle Enterprise Linux 5.6, Debian 6, Windows XP/Vista/7/8, Java 6, Chrome 19 and CryptoPro CSP 3.6 R2 are historical references. Do not recommend deploying these versions today without a separate security, compatibility and legal review.

## Related documents

- [Deployment architecture](03-deployment-architecture.md)
- [Lifecycle, updates and operational support](06-lifecycle-testing.md)


## Additional historical hardware profile details

The supplied source gives separate profiles for the database server, application server, combined application/database server and a separately described low-capacity dedicated server. Their values are summarized in [Deployment Architecture](03-deployment-architecture.md). The CPU strings `4 core-x1`, `4 core-x2` and `6 core-x2` are preserved as source notation; their hardware meaning is not established.

The client profile additionally names the special-printer DLLs, Google Chrome 19 or later, MS Word/Excel or an equivalent, Java Runtime Environment 6 and CryptoPro CSP 3.6 R2.

The stated network thresholds are historical: 256 Kbit/s for up to 50 cases/day, 512 Kbit/s for 50–100 cases/day and 1 Mbit/s for more than 100 cases/day. Concurrent users, payload sizes and latency requirements are absent, so these figures are not a complete capacity model.
