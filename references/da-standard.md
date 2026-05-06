# DA Layering Standard (Data Architecture)

Uses a **top-down planning design, bottom-up precise adjustment** subject domain design methodology.

---

## L1 Subject Domain Group

The data "strategic map."

- **Principle**: Follow MECE (Mutually Exclusive, Collectively Exhaustive); stable long-term, unaffected by system changes
- **Naming**: `[Core Object/Domain] + [Domain]`
- **Prohibited**: Verbs, technical terms, system module names
- **Examples**: Customer & Marketing Domain, Product & Solution Domain, Service & Delivery Domain

---

## L2 Subject Domain

Data "logical cluster," centered on business protagonists.

- **Principle**: De-systemized; does not reflect technical implementation; named by business subject, not system names
- **Naming**: `[Core Business Subject] + [Management]`
- **Examples**: Opportunity Management, Customer Profile Management, Renewal Management, Success Plan Management

---

## L3 Subject Sub-domain

Data "management scope," serving as mounting nodes for the data asset catalog.

- **Principle**: Asset-oriented, no-verb naming; balances physical storage asset attributes and business catalog management scope
- **Naming**: `[Object/Scenario Modifier] + [Information/Data/Trail]`, or direct business object combinations
- **Prohibited**: Verb naming (e.g., "Quotation Approval" → should be "Quotation Approval Information")
- **Examples**: Opportunity Solutions & Quotations, Customer Health Data, Renewal Contract Information, Contact Records & Interaction Trail

---

## L4 Business Object (BO)

> **The 1-end of N:1:1 derivation (data side) — the core data anchor for architecture derivation.**

The "atomic noun" of data, with unique identity and business completeness.

- **Principle**: Unified business semantics; one concept has only one BO; possesses independent lifecycle and state machine
- **Naming**: `[Core Business Noun]` (concise noun, no modifiers)
- **Prohibited**: Technical terms (Record/Entity/Table), verbs, compound gerunds
- **Examples**:
  - ✅ Quotation, Customer Profile, Health Score, Renewal Contract, Success Plan
  - ❌ Quotation Record (technical term), Create Quotation (verb)

**Criteria for extracting a BO:**

| Question | Answer | Conclusion |
|----------|--------|------------|
| Has independent lifecycle and state machine? | Yes | → Is a BO |
| Exists only as an association between two BOs? | Yes | → Usually not an independent BO |
| Referenced in multiple L4 processes? | Yes | → Strong signal of an independent BO |
| Can be independently queried, modified, archived? | Yes | → Is a BO |

---

## L5 Logical Entity / Attribute

The "structured decomposition" of a BO, guiding physical data modeling.

- **Principle**: **Static-dynamic separation** — main entity stores core stable attributes; extension entities store dynamic/multi-value/historical data
- **Naming**: `[L4 Name] + [Structure Descriptor] + [Entity]`
- **Common structure descriptors**:
  - `Main Entity` — Core attributes (name, status, related foreign keys, etc.)
  - `Terms Entity` — Contract-type BO line items/terms
  - `Approval Entity` — Approval workflow records
  - `History Entity` — Version snapshots or time-series records
  - `Detail Entity` — Line items / list-type data
- **Examples**: Quotation Main Entity, Quotation Terms Entity, Renewal Contract Approval Entity, Health Score History Entity
