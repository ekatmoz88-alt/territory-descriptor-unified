# System Context and Architecture Boundaries of the Unified Workstation

> **System boundary:** The case-processing workstation is a single software system. POSS, POMS, and POSH VBD are its internal contours. “Citizens” is an internal functional area for individual dossiers. The external SOAP service is a separate integration boundary.

> **Evidence status:** this document presents a logical model and historical architecture evidence. It is not a reconstruction of a specific installation's physical topology.

## 1. Identity and boundaries

| Term | Meaning |
|---|---|
| Case Processing Workstation | Name of the software workstation / complex |
| Case Processing Workstation | Alternative name for the same workstation |
| Project designation | Not published |
| Case Processing Workstation | English designation for the same workstation |
| POSS | Internal stationary contour |
| POMS | Internal mobile contour |
| POSH VBD | Internal gateway contour for access to VBD |
| “Citizens” | Internal functional area for individual dossiers |
| External SOAP service | External integration boundary |

Do not automatically equate POSS, POMS, or POSH VBD with `ModuleStationary`, `ModuleMobile`, or specific assemblies. These are different classification levels; mappings require traceability to specifications and source code.

## 2. Logical context diagram

```mermaid
flowchart LR
  subgraph ARM["Unified Case Processing Workstation"]
    direction TB
    POSS["POSS — stationary contour"]
    POMS["POMS — mobile contour"]
    POSHVBD["POSH VBD — internal gateway contour"]
    CIT["Citizens — functional area"]
    POSS <-->|"Internal exchange; details to verify"| POMS
    POMS <-->|"Gateway route; details to verify"| POSHVBD
    POSS --- CIT
    POMS --- CIT
  end
  VBD["External departmental database"]
  EXTERNAL_SERVICE["External SOAP service"]
  POSHVBD <-->|"VBD access; protocol to verify"| VBD
  ARM -.->|"Integration contract; runtime flow to verify"| EXTERNAL_SERVICE
```

This is a boundary view, not a claim about a specific protocol or physical network topology. Internal routes must be checked against the original specification and source code.

## 3. Historical architecture evidence

Historical documentation includes a three-tier web architecture: client interface, application server, and database server. This is retained as source evidence, but it does not prove that POSS, POMS, or POSH VBD are implemented as web clients/servers or belong to a second application boundary. That wording must not override the canonical identity of the single workstation.

Historical sources also describe centralized and distributed deployment modes. Their applicability to specific workstation contours requires verification against the primary document and the configuration of an actual installation.

## 4. Integrations

- The external SOAP service is a separate integration boundary; contract details and runtime routing are documented separately.
- VBD is an external departmental database accessed through the workstation's internal POSH VBD contour.
- File exchange between internal contours and MRZ are documented in [integration architecture](./integration-and-file-exchange.md) and [format specifications](./data-exchange-and-mrz.md).

## 5. Evidence limitations

- The identity of the four workstation names is the canonical documentation rule.
- `ConnectionFactory.cs` alone does not prove POSH VBD implementation; it belongs only to the SQLite DAL.
- POSS/`ModuleStationary` and POMS/`ModuleMobile` mappings are not considered established without explicit traceability.
- A SOAP ViewModel or a reference to `UmmsNp.cs` does not prove the endpoint, authorization, or complete network flow.
