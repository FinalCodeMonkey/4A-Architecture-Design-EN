# Design Red Lines & Principles

---

## Principle 1 — Dual-Line Parallel and Convergence (BA)

- The Value Line defines the objective (What); the Capability Line provides the support (How). Neither can be omitted.
- Both must **decouple and converge** at Layer L4:
  - **Decouple**: The same L3 Business Activity can correspond to multiple L4 Processes (due to different scenario rules)
  - **Converge**: Different processes share the same BO (N:1 derivation anchor)
- **Prohibited**: Skipping L4 and mapping directly from L3 to L5; using an L3 Business Activity as a Process

---

## Principle 2 — De-verbification and Nominalization (DA)

DA L1-L4 **absolutely prohibits** verbs, system module names (e.g., CRM, ERP), and technical codes (e.g., UserTable).

Record only **"result assets"**, not "process actions."

| ❌ Wrong (Verb / Technical Term) | ✅ Correct (Result Asset Noun) |
|----------------------------------|-------------------------------|
| Quotation Approval Process | Quotation Approval Information |
| Follow-up Customer Action | Customer Outreach Record |
| Health Score Calculation | Health Score |
| Renewal Prediction Engine | Renewal Prediction |
| CRM Opportunity Module | Opportunity |

---

## Principle 3 — MECE and Clear Data Ownership (DA)

- Each DA layer follows MECE (Mutually Exclusive, Collectively Exhaustive)
- Each BO has one and only one clearly defined **Data Owner** (mapped to an AA-L3 Application / AA-L4 Service)
- **Eliminate**: Cross-domain gray areas (situations where the same data is claimed by multiple subject domains)
- **Eliminate**: Gray BOs (the same business concept having different names in different places)

---

## Principle 4 — The Balancing Art of L3 (DA L3)

DA-L3 balances two perspectives:

1. **Asset Catalog Perspective**: Serves as the hub for mounting data assets, supporting management-layer data governance and asset discovery
2. **Physical Storage Perspective**: Points to real data boundaries; avoids over-granulation or over-consolidation

**Typical errors:**
- L3 granularity too fine → Indistinguishable from L4 BO; effectively redundant
- L3 granularity too coarse → Indistinguishable from L2; layer collapse

---

## Principle 5 — Capability Alignment (AA)

- AA-L1/L2 must **strongly correspond** to BA Capability Domains / DA Subject Domains (consistent sovereignty boundaries)
- AA-L4 **must** bind 1:1 with DA-L4 BO:
  - Prohibited: 1 service managing multiple BOs (logical silo)
  - Prohibited: 1 BO managed by multiple services (state machine fragmentation)
- The `AA-L3 Microservice ↔ DA-L3 Subject Sub-domain` correspondence must be traceable

---

## Principle 6 — Semantic Consistency Throughout (Cross-Architecture)

- All three architectures (BA / DA / AA) use the **same unified business language**; the same concept uses the same term
- **"Blueprint as Code Map"**: Architecture naming directly guides code package names, class names, and API paths:
  - DA-L4 BO name → aggregate root class name in code
  - AA-L4 service name → Service class name in code
  - AA-L5 interface name → Controller method name in code
- Semantic ambiguity must be resolved at Layer L4 and must not carry over to the coding phase

---

## Principle 7 — Completeness Requirement (Output)

**All architecture design outputs must include complete L1-L5. Simplification using "examples" or "..." is strictly forbidden.**

Standard output template must include:

1. **BA Layer Table** (Value Line + Capability Line, L1-L5, all entries)
2. **DA Layer Table** (L1-L5, including all BOs and their logical entities)
3. **AA Layer Table** (L1-L5, including all services and interfaces)
4. **N:1:1 Mapping Matrix** (BA-L4 Process × DA-L4 BO × AA-L4 Service, full cross-reference)
5. **Three-Layer Alignment Verification Table** (BA Capability Domain ↔ DA Subject Domain ↔ AA Sub-product, row-by-row verification)
