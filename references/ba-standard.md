# BA Layering Standard (Business Architecture)

Business architecture uses a "Value Chain Line" and "Capability Line" dual-dimension complementary design; both converge at L4 to form executable processes.

---

## L1 Enterprise Level

| Dimension | Name | Description | Naming Convention | Examples |
|-----------|------|-------------|-------------------|----------|
| Value Line | **Value Chain** | Highest-level end-to-end business logic, verb/verb-object | `From X to Y` (e.g., Lead to Cash) | Market to Lead (MTL), Lead to Cash (LTC), Customer Success Management (CSM) |
| Capability Line | **Capability Domain** | Highest-level business capability cluster, noun | Noun, stable over time | Sales Enablement, Customer Success, Product & Service |

The two dimensions have a many-to-many support relationship: one capability domain can support multiple value chains.

---

## L2 Domain Level

| Dimension | Name | Description | Naming Convention | Examples |
|-----------|------|-------------|-------------------|----------|
| Value Line | **Value Stage** | Core stage decomposition of the value chain | Verb + Object | Manage Leads, Progress Opportunities, Execute Delivery |
| Capability Line | **Capability Group** | Logical capability cluster under the capability domain | Noun | Lead Management, Opportunity Management, Customer Onboarding |

Value stages invoke capability groups in a many-to-many relationship.

---

## L3 Scenario Level

| Dimension | Name | Description | Naming Convention | Examples |
|-----------|------|-------------|-------------------|----------|
| Value Line | **Business Activity** | Key scenario nodes within a stage | Verb + Object | Confirm Requirements, Define Solution, Sign Contract |
| Capability Line | **Capability** | Minimum independently deliverable business capability unit | Noun / Verb-Object | Requirement Analysis & Guidance, Solution Design & Presentation |

Both converge at L3, **jointly pointing to L4 processes**.

---

## L4 Process Level

> **The N-end of N:1:1 derivation — this is the core derivation anchor.**

A complete workflow orchestrated to achieve an L3 objective. The same business activity may spawn multiple L4 processes due to different scenarios or rules.

- **Naming convention**: `[Business Object] + [Core Action] + "Process"`
- **Differentiation criteria**: Different business scenarios, customer types, product types, rule variations
- **Examples**:
  - Standard Product Solution Design Process
  - Custom Solution Design Process
  - Customer Onboarding Execution Process
  - Renewal Contract Approval Process (Standard)
  - Renewal Contract Approval Process (Downgrade)

---

## L5 Operation Level

The smallest work unit; execution layer; cannot be further decomposed.

- **Naming convention**: `Verb + Object`
- **Examples**: Create Solution Draft, Submit Approval Request, Update Customer Status, Send Notification Message
