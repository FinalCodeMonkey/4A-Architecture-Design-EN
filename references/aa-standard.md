# AA Layering Standard (Application Architecture)

Application Architecture describes the application systems and service components required to realize business capabilities.

---

## L1 Product

The IT strategic map; sovereignty boundaries strictly aligned with DA-L1 Subject Domain Groups.

- **Alignment**: AA-L1 sovereignty boundaries must be consistent with DA-L1
- **Naming**: `[Business Domain Name] + [System / Platform]`
- **Examples**: Customer Relationship Management System (CRM), Customer Success Management Platform (CSM), Product & Delivery Platform

---

## L2 Sub-product

The "management center" for core objects; aligned with DA-L2 Subject Domains.

- **Naming**: `[Core Object] + [Management Center / Sub-system]`
- **Examples**: Opportunity Management Center, Customer Profile Management Center, Renewal Management Center, Customer Success & Health Center

---

## L3 Application / Microservice

Business scenario runtime unit; logically corresponds to one Bounded Context.

- **Principles**:
  - **Logical independence**: Each L3 application encapsulates one Bounded Context and can evolve independently
  - **Expansion joint principle**: Logically separated; physical deployment can be merged (based on scale)
  - Aligned with DA-L3 Subject Sub-domains
- **Naming**: `[Scenario / Scope Modifier] + [Application / Service / Engine]`
- **Examples**: Customer Profile Application, Health Score Engine, Risk Alert Engine, Onboarding Plan Orchestration Service, Renewal Management Application

> **Expansion Joint Principle**: L3 applications are logically independent and can iterate separately. In physical deployment, they may be merged or split based on team size or traffic requirements, without affecting logical boundaries.

---

## L4 Service / Module

> **The 1 end (application side) of N:1:1 derivation — strictly 1:1 with DA-L4 BO.**

Each DA-L4 BO has one and only one AA-L4 service as its sole logical proxy.

- **Principles**: High cohesion; encapsulates the full state machine and business rules of a single BO; serves as the sole authoritative manager of that BO in the system
- **Naming**: `[DA-L4 BO Name] + [Service]`
- **Examples**: Quotation Service, Health Score Service, Renewal Contract Service, Success Plan Service, Risk Alert Service

**Significance of the 1:1 constraint:**

| Violation Pattern | Problem |
|-------------------|---------|
| 1 service manages multiple BOs | → Logical silo; state machines cross; difficult to split |
| 1 BO managed by multiple services | → State machine fragmentation; data consistency risk |
| Service name inconsistent with BO | → Semantic ambiguity; blueprint and code misaligned |

---

## L5 Function / Interface

The "atomic operational behaviors" of logical entities; directly guides API design.

- **Naming**: `[Action] + [Entity Name] + [API]`
- **Common actions**: Create, Query, Update, Delete, Submit, Approve, Publish, Archive, Close
- **Examples**:
  - Create Solution Proposal API
  - Query Customer Health Score API
  - Submit Renewal Contract Approval API
  - Publish Success Plan API
  - Close Risk Alert API
