# DA Layering Standard (Data Architecture)

Adopts a **top-down planning and design, bottom-up precise calibration** approach for subject domain design.

---

## L1 Subject Domain Group

The data "strategic map."

- **Principles**: Follow MECE (Mutually Exclusive, Collectively Exhaustive); long-term stable, not changed by system changes
- **Naming**: `[Core Object / Domain] + [Domain]`
- **Prohibited**: Verbs, technical terms, system module names
- **Examples**: Customer & Marketing Domain, Product & Solution Domain, Service & Delivery Domain

---

## L2 Subject Domain

The data "logical cluster," centered on the business protagonist.

- **Principles**: De-systemized; does not reflect technical implementation; named after business subjects, not system names
- **Naming**: `[Core Business Subject] + [Management]`
- **Examples**: Opportunity Management, Customer Profile Management, Renewal Management, Success Plan Management

---

## L3 Subject Sub-domain

The data "management scope," serving as the mount node for the data asset catalog.

- **Principles**: Asset-oriented, de-verbified; balances physical storage asset attributes and business catalog management scope
- **Naming**: `[Object / Scenario Modifier] + [Information / Data / Trail]`, or direct business object combinations
- **Prohibited**: Verb naming (e.g., "Quotation Approval" → should be "Quotation Approval Information")
- **Examples**: Solution & Quotation, Customer Health Data, Renewal Contract Information, Outreach Records & Interaction Trail

---

## L4 Business Object (BO)

> **The 1 end (data side) of N:1:1 derivation — the core data anchor for architecture derivation.**

The data "atomic noun," with unique identity and business completeness.

- **Principles**: Unified business semantics; one concept can only have one BO; has an independent lifecycle and state machine
- **Naming**: `[Core Business Noun]` (concise noun, no modifiers)
- **Prohibited**: Technical terms (Record / Entity / Table), verbs, compound gerunds
- **Examples**:
  - ✅ Quotation, Customer Profile, Health Score, Renewal Contract, Success Plan
  - ❌ Quotation Record (technical term), Create Quotation (verb)

**BO Extraction Criteria:**

| Judgment Question | Answer | Conclusion |
|-------------------|--------|------------|
| Has an independent lifecycle and state machine? | Yes | → Is a BO |
| Exists only as an association between two BOs? | Yes | → Usually not an independent BO |
| Referenced across multiple L4 processes? | Yes | → Strong signal of an independent BO |
| Can be independently queried, modified, or archived? | Yes | → Is a BO |

---

## L5 Logical Entity / Attribute

The "structured decomposition" of a BO, guiding physical data modeling.

- **Principles**: **Separate static from dynamic** — main entity stores core stable attributes; extension entities store dynamic / multi-value / historical data
- **Naming**: `[L4 Name] + [Structure Descriptor] + [Entity]`
- **Common structure descriptors**:
  - `Main Entity` — core attributes (name, status, foreign keys, etc.)
  - `Line Item Entity` — contract-type BO clause rows
  - `Approval Entity` — approval flow records
  - `History Entity` — version snapshots or time-series records
  - `Detail Entity` — row-item / list data
- **Examples**: Quotation Main Entity, Quotation Line Item Entity, Renewal Contract Approval Entity, Health Score History Entity
