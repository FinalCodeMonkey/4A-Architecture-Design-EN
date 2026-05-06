# AA Layering Standard (Application Architecture)

Application architecture describes the application systems and service components required to realize business capabilities.

---

## L1 Product

IT strategic map; ownership boundaries strictly aligned with DA-L1 Subject Domain Groups.

- **Alignment**: AA-L1 ownership boundaries MUST be consistent with DA-L1
- **Naming**: `[Business Domain Name] + [System/Platform]`
- **Examples**: Customer Relationship Management System (CRM), Customer Success Management Platform (CSM), Product & Delivery Platform

---

## L2 Sub-product

The "management center" for core objects, aligned with DA-L2 Subject Domains.

- **Naming**: `[Core Object] + [Management Center / Subsystem]`
- **Examples**: Opportunity Management Center, Customer Profile Management Center, Renewal Management Center, Customer Success & Health Center

---

## L3 Application / Microservice

Business scenario execution unit; logically corresponds to a Bounded Context.

- **Principles**:
  - **Logical independence**: Each L3 application encapsulates one bounded context; can evolve independently
  - **Expansion Joint principle**: Logical separation; physical deployment can be merged (depending on scale)
  - Aligned with DA-L3 Subject Sub-domains
- **Naming**: `[Scenario/Scope Modifier] + [Application/Service/Engine]`
- **Examples**: Customer Portrait Application, Health Scoring Engine, Risk Alert Engine, Onboarding Plan Orchestration Service, Renewal Management Application

> **Expansion Joint Principle**: L3 applications are logically independent and can iterate separately; in physical deployment they can be merged or split based on team size or traffic needs, without affecting logical boundaries.

---

## L4 Service / Module

> **The 1-end of N:1:1 derivation (application side) — strictly 1:1 corresponding to DA-L4 BO.**

Every DA-L4 BO has exactly one AA-L4 service as its sole logical proxy.

- **Principle**: High cohesion; encapsulates all state machine logic and business rules for a single BO; acts as the BO's sole authoritative manager in the system
- **Naming**: `[DA-L4 BO Name] + [Service]`
- **Examples**: Quotation Service, Health Score Service, Renewal Contract Service, Success Plan Service, Risk Alert Service

**Significance of the 1:1 constraint:**

| Violation Pattern | Problem |
|-------------------|---------|
| 1 service manages multiple BOs | → Logical silo; state machines interleave; hard to split |
| 1 BO managed by multiple services | → State machine fragmentation; data consistency risk |
| Service name inconsistent with BO | → Semantic ambiguity; blueprint doesn't map to code |

---

## L5 Function / Interface

The "atomic operational behavior" of logical entities, directly guiding API design.

- **Naming**: `[Action] + [Entity Name] + [API]`
- **Common actions**: Create, Query, Update, Delete, Submit, Approve, Publish, Archive, Close
- **Examples**:
  - Create Solution Proposal API
  - Query Customer Health Score API
  - Submit Renewal Contract Approval API
  - Publish Success Plan API
  - Close Risk Alert API
