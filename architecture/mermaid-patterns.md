# Mermaid diagram patterns and reusable templates

> **Purpose / Назначение:** a copy-and-adapt library of Mermaid patterns for enterprise technical documentation. Mermaid does not provide user-defined callable macros; these files are reusable templates/snippets, not executable macros.
>
> **How to use:** copy a fenced `mermaid` block, replace the clearly marked placeholders, keep only relationships supported by evidence, then render it in the architecture catalogue.

## 1. Conventions

- Use stable, descriptive node IDs in `UPPER_SNAKE_CASE`; keep display labels readable.
- One diagram should answer one architectural question.
- Label every cross-system edge with the actual interface or exchange mechanism. If unknown, label it `[protocol to verify]` rather than guessing.
- Use subgraphs for ownership or trust boundaries, not merely to group visually related nodes.
- Distinguish documented facts from derived views and unverified details in the surrounding prose.
- Avoid production secrets, personal data, real credentials, and sensitive endpoint values.
- Keep line breaks in labels as `<br/>`; quote labels containing punctuation or special characters.
- Prefer a small number of meaningful edge types. Explain dotted/dashed relationships in a legend.

## 2. System context / system boundary

Use when documenting a system, its users, and external actors. Replace all bracketed labels.

```mermaid
flowchart LR
  USER["[User role]"]
  SYSTEM["[System name]<br/>[Primary responsibility]"]
  EXT_A["[External system A]"]
  EXT_B["[External system B]"]

  USER -->|"[User action]"| SYSTEM
  SYSTEM <-->|"[Verified interface / exchange]"| EXT_A
  SYSTEM -.->|"[Unverified / proposed relationship]"| EXT_B
```

## 3. Container / deployment view

Use for deployable applications, services, databases, and infrastructure boundaries. Do not imply a deployment topology unless a deployment source supports it.

```mermaid
flowchart TB
  subgraph ENV["[Environment / site boundary]"]
    CLIENT["[Client / workstation]"]
    APP["[Application / service]<br/>[Runtime or technology, if verified]"]
    DB[("[Database]<br/>[DBMS, if verified]")]
    CLIENT -->|"[Verified protocol]"| APP
    APP -->|"[Driver / protocol, if verified]"| DB
  end
  EXT["[External dependency]"]
  APP <-->|"[Contract / exchange]"| EXT
```

## 4. Component map

Use to show responsibilities inside one application or bounded component. Keep the diagram at one level of detail.

```mermaid
flowchart TB
  subgraph APP["[Application / bounded context]"]
    UI["[Presentation / UI]"]
    SERVICE["[Application service]"]
    DOMAIN["[Domain logic]"]
    REPOSITORY["[Repository / data access]"]
    UI --> SERVICE --> DOMAIN --> REPOSITORY
  end
  DB[("[Data store]")]
  REPOSITORY --> DB
```

## 5. Data flow / exchange

Use to document a file, message, or API exchange. Name formats and transfer mechanisms only when verified.

```mermaid
flowchart LR
  SOURCE["[Source system]"]
  EXPORT["[Export / producer]"]
  TRANSFER["[Transfer boundary]<br/>[Format / protocol]"]
  IMPORT["[Import / consumer]"]
  TARGET["[Target system]"]
  SOURCE --> EXPORT --> TRANSFER --> IMPORT --> TARGET
  ERROR["[Validation / error handling]"]
  IMPORT -.-> ERROR
```

## 6. Sequence / API interaction

Use for request-response flows. Replace operations with names from the actual API contract; mark asynchronous behavior explicitly.

```mermaid
sequenceDiagram
  autonumber
  actor User as [User / caller]
  participant Client as [Client]
  participant API as [API / service]
  participant Store as [Data store]

  User->>Client: [Initiate action]
  Client->>API: [Operation / request]
  API->>Store: [Read / write]
  Store-->>API: [Result]
  API-->>Client: [Response / status]
  Client-->>User: [Outcome]
```

## 7. Entity relationship model

Use for conceptual or physical data models. Mark the model type in the title/caption. Do not present inferred links as verified foreign keys.

```mermaid
erDiagram
  ENTITY_A ||--o{ ENTITY_B : "[relationship]"
  ENTITY_B }o--|| ENTITY_C : "[relationship]"
  ENTITY_A {
    string id PK
    string name
  }
  ENTITY_B {
    string id PK
    string entity_a_id FK
    string entity_c_id FK
  }
  ENTITY_C {
    string id PK
    string code
  }
```

## 8. State machine

Use when documenting lifecycle states and allowed transitions. Include only states and transitions supported by a specification or observed implementation.

```mermaid
stateDiagram-v2
  [*] --> Draft
  Draft --> Submitted: [submit condition]
  Submitted --> Approved: [approval condition]
  Submitted --> Rejected: [rejection condition]
  Rejected --> Draft: [correction]
  Approved --> [*]
```

## 9. Standard styling fragment

Copy the `classDef` declarations into a diagram when consistent visual roles help readability. Assign classes only where the meaning is clear.

```mermaid
flowchart LR
  USER["User / actor"]
  APP["Application"]
  DATA[("Data store")]
  EXT["External system"]
  UNKNOWN["Unverified detail"]

  USER --> APP
  APP --> DATA
  APP <--> EXT
  APP -.-> UNKNOWN

  classDef actor fill:#E8F1FB,stroke:#356A9A,color:#17324D
  classDef application fill:#EAF5EA,stroke:#4B7A4B,color:#203B20
  classDef datastore fill:#FFF3D6,stroke:#A87920,color:#503A12
  classDef external fill:#F1EAF8,stroke:#76539A,color:#38234D
  classDef unverified fill:#F3F3F3,stroke:#777,color:#333,stroke-dasharray: 4 3

  class USER actor
  class APP application
  class DATA datastore
  class EXT external
  class UNKNOWN unverified
```

## 10. Review checklist

- [ ] The diagram has a clear title and one purpose.
- [ ] System and trust boundaries are explicit.
- [ ] Every arrow has a meaningful direction and, where needed, a label.
- [ ] Protocols, formats, technologies, and cardinalities are evidence-backed.
- [ ] Inferred or unverified relationships are visibly distinguished.
- [ ] Node IDs are unique and labels are concise.
- [ ] The Mermaid block renders in the repository's Mermaid 11 catalogue.
- [ ] The surrounding text states source, scope, limitations, and verification gaps.

## 11. Project-specific usage

For this repository, keep PPO Territory, ARM «Дискриптор», Deshifrator, UMMS, and supplementary source systems as separate boundaries unless evidence explicitly demonstrates an integration. Reuse the patterns above to create consistent views; do not copy example entities or relationships as facts about the documented systems.

**Related:** [Architecture catalogue](./README.md) · [Interactive EN/RU diagrams](./architecture.html) · [Component maps](./component-maps.md)
