# BA Layering Standard (Business Architecture)

Business Architecture adopts a dual-dimension complementary design of a "Value Chain Line" and a "Capability Line". Both converge at Layer 4 (L4) to form executable processes.

---

## L1 Enterprise Level

| Dimension | Name | Description | Naming Convention | Examples |
|-----------|------|-------------|-------------------|---------|
| Value Line | **Value Chain** | Highest-level end-to-end business logic; verb/verb-object | `From X to Y` (e.g., Lead to Cash) | Market to Lead (MTL), Lead to Cash (LTC), Customer Success Management (CSM) |
| Capability Line | **Capability Domain** | Highest-level business capability cluster; noun | Noun, stable and unchanging | Sales Enablement, Customer Success, Product & Delivery |

The two have a many-to-many support relationship: one Capability Domain can support multiple Value Chains.

---

## L2 Domain Level

| Dimension | Name | Description | Naming Convention | Examples |
|-----------|------|-------------|-------------------|---------|
| Value Line | **Value Stage** | Core stage breakdown of the value chain | Verb + Object | Manage Leads, Advance Opportunities, Execute Delivery |
| Capability Line | **Capability Group** | Logical capability cluster under a Capability Domain | Noun | Lead Management, Opportunity Management, Customer Onboarding |

Value Stages invoke Capability Groups in a many-to-many relationship.

---

## L3 Scenario Level

| Dimension | Name | Description | Naming Convention | Examples |
|-----------|------|-------------|-------------------|---------|
| Value Line | **Business Activity** | Key scenario nodes within a stage | Verb + Object | Confirm Requirements, Develop Solution, Sign Contract |
| Capability Line | **Capability** | Smallest independently deliverable business capability unit | Noun / Verb-Object | Requirements Analysis & Facilitation, Solution Development & Presentation |

The two intersect at L3 and **jointly point to L4 Processes**.

---

## L4 Process Level

> **The N end of N:1:1 derivation — this is the core derivation anchor.**

A complete workflow orchestrated to achieve an L3 objective. The same Business Activity can spawn multiple L4 processes due to different scenarios or rules.

- **Naming convention**: `[Business Object] + [Core Action] + "Process"`
- **Differentiation basis**: Different business scenarios, customer types, product types, or rule variations
- **Examples**:
  - Standard Product Solution Development Process
  - Custom Solution Development Process
  - Customer Onboarding Execution Process
  - Renewal Contract Approval Process (Standard)
  - Renewal Contract Approval Process (Discounted)

---

## L5 Operation Level

The smallest unit of work; execution layer; cannot be further decomposed.

- **Naming convention**: `Verb + Object`
- **Examples**: Create Solution Draft, Submit Approval Request, Update Customer Status, Send Notification Message
