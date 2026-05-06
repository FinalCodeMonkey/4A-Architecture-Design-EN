# Design Red Lines & Principles

---

## Principle 1 — Dual-Line Parallelism & Convergence (BA)

- Value line defines objectives (What); capability line provides support (How) — both are indispensable
- Both MUST **decouple and converge** at L4:
  - **Decoupling**: The same L3 business activity can correspond to multiple L4 processes (due to different scenario rules)
  - **Convergence**: Different processes share the same BO (N:1 derivation anchor)
- **Prohibited**: Skipping L4 to map directly from L3 to L5; using L3 business activities as processes

---

## Principle 2 — No-Verb & Noun-Only Rule (DA)

DA L1-L4 **absolutely prohibits** verbs, system module names (e.g., CRM, ERP), and technical codes (e.g., UserTable).

Only record "**result assets**," not "process actions."

| ❌ Wrong (Verb/Technical) | ✅ Correct (Result Asset Noun) |
|--------------------------|-------------------------------|
| Quotation Approval Process | Quotation Approval Information |
| Follow Up Customer Action | Customer Contact Record |
| Health Score Calculation | Health Score |
| Renewal Prediction Engine | Renewal Prediction |
| CRM Opportunity Module | Opportunity |

---

## Principle 3 — Mutual Exclusivity & Clear Ownership (DA MECE)

- All DA layers follow MECE (Mutually Exclusive, Collectively Exhaustive)
- Every BO has exactly one explicit **Data Owner** (corresponding AA-L3 application / AA-L4 service)
- **Eliminate**: Cross-domain grey areas (same data claimed by multiple subject domains)
- **Eliminate**: Grey BOs (same business concept with different names in different places)

---

## Principle 4 — The Balancing Art of L3 (DA L3)

DA-L3 balances two perspectives:

1. **Asset catalog perspective**: Serves as the hub for data asset mounting; supports management-level data governance and asset discovery
2. **Physical storage perspective**: Points to real data boundaries; avoids excessive granularity or excessive aggregation

**Typical errors:**
- L3 granularity too fine → indistinguishable from L4 BO; serves no purpose
- L3 granularity too coarse → indistinguishable from L2; level collapse

---

## Principle 5 — Capability Inheritance & Alignment (AA)

- AA-L1/L2 MUST **strongly correspond** to BA capability domains / DA subject domains (ownership boundaries consistent)
- AA-L4 **MUST** be 1:1 bound to DA-L4 BO:
  - Prohibited: 1 service managing multiple BOs (logical silo)
  - Prohibited: 1 BO managed by multiple services (state machine fragmentation)
- `AA-L3 microservice ↔ DA-L3 subject sub-domain` correspondence must be traceable

---

## Principle 6 — Semantic Consistency Throughout (Cross-Architecture)

- All three architectures (BA/DA/AA) use **the same business language**; identical concepts use identical terms
- "**Blueprint-as-code-map**": Architecture naming directly guides code package names, class names, API paths
  - DA-L4 BO name → Aggregate root class name in code
  - AA-L4 service name → Service class name in code
  - AA-L5 interface name → Controller method name in code
- Semantic ambiguity MUST be eliminated at L4; never deferred to the coding phase

---

## Principle 7 — Completeness Requirement (Output)

**All architecture design outputs MUST include complete L1-L5; NEVER simplify with "example" or "...".**

Standard output template should contain:

1. **BA Layer Table** (value line + capability line, L1-L5, all entries)
2. **DA Layer Table** (L1-L5, including all BOs and their logical entities)
3. **AA Layer Table** (L1-L5, including all services and interfaces)
4. **N:1:1 Mapping Matrix** (BA-L4 processes × DA-L4 BO × AA-L4 services, complete cross-reference)
5. **Tri-Architecture Alignment Verification Table** (BA capability domain ↔ DA subject domain ↔ AA sub-product, row-by-row verification)
