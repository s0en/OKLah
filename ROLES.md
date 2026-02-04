# Roles & Handoffs — OKLah

This document consolidates **all role DILOs** (Day‑In‑the‑Life Operating models) and **handoff checklists** for the OKLah delivery system.

It is the authoritative reference for:

* who owns what
* when work may begin
* when work is considered complete
* how responsibility is handed off safely

---

## Roles Covered

1. Product Owner (PO)
2. Business Analyst (BA)
3. Solution Architect (SA)
4. Engineering Lead (EL)
5. Software Engineer (SE)

Each role section contains:

* Purpose & mindset
* Core responsibilities
* Entry conditions
* Exit conditions
* Explicit handoff checklist

---

# 1. Product Owner (PO)

## Purpose

The Product Owner is the **guardian of intent, scope, and success**.

They answer **WHY** and **WHAT**, never **HOW**.

---

## PO Responsibilities

* Own BRF, BRD, PRDs
* Define success metrics
* Decide scope and non‑goals
* Resolve trade‑offs
* Maintain a single source of product truth

PO never:

* designs architecture
* writes specs
* estimates tasks
* chooses technologies

---

## PO Entry Conditions

* A business problem or opportunity exists

---

## PO Exit Conditions

* PRD is approved
* Scope and non‑goals are explicit
* Success metrics are defined
* No hidden assumptions remain

---

## PO → BA Handoff Checklist

Before handing a PRD to BA, PO confirms:

* [ ] BRF exists and is approved
* [ ] BRD exists and aligns to BRF
* [ ] PRD represents one shippable slice
* [ ] In‑scope and out‑of‑scope are explicit
* [ ] Success metrics are stated
* [ ] No technical design is embedded

If BA asks "Is X in scope?", the answer must already exist in the PRD.

---

# 2. Business Analyst (BA)

## Purpose

The Business Analyst converts **product intent into unambiguous functional behaviour**.

They answer **WHAT EXACTLY HAPPENS**, not how it is built.

---

## BA Responsibilities

* Derive FSD specs from PRDs
* Define functional behaviour
* Define states, flows, validations, errors
* Define acceptance criteria
* Run clarification loops

BA never:

* designs architecture
* writes code
* estimates delivery
* invents scope

---

## BA Entry Conditions

* Approved PRD exists
* Scope is stable enough to specify

---

## BA Exit Conditions

* Specs are implementation‑ready
* No unresolved ambiguity remains
* Acceptance criteria are testable
* Specs trace cleanly to PRD

---

## BA → SA Handoff Checklist

Before handing specs to SA, BA confirms:

* [ ] Specs exist at `docs/fsd/**/spec.md`
* [ ] All flows have start/end states
* [ ] All edge cases are defined
* [ ] All assumptions are documented
* [ ] Clarification loop is complete
* [ ] No architecture or tooling decisions exist in specs

---

# 3. Solution Architect (SA)

## Purpose

The Solution Architect ensures the system can be **built, operated, and evolved safely**.

They answer **HOW (system‑level)** and **UNDER WHAT CONSTRAINTS**.

---

## SA Responsibilities

* Define system structure
* Define component boundaries
* Define NFRs
* Record ADRs
* Surface technical risks

SA never:

* changes product scope
* rewrites specs
* writes code
* plans sprints

---

## SA Entry Conditions

* PRD approved
* FSD specs complete and clarified

---

## SA Exit Conditions

* Architecture plan exists
* NFRs documented
* ADRs recorded
* Risks acknowledged

---

## SA → EL Handoff Checklist

Before handing off to EL, SA confirms:

* [ ] Architecture plan exists (`plans/*.implementation.md`)
* [ ] NFRs exist under `docs/nonfunctional/`
* [ ] ADRs recorded for irreversible decisions
* [ ] No scope drift introduced
* [ ] BA confirms correct interpretation of specs

---

# 4. Engineering Lead (EL)

## Purpose

The Engineering Lead turns **approved intent into executable delivery**.

They answer **HOW DO WE SHIP THIS SAFELY**.

---

## EL Responsibilities

* Break work into tasks
* Sequence delivery
* Enforce quality gates
* Govern releases
* Surface delivery risk

EL never:

* invents requirements
* redesigns architecture
* bypasses quality controls

---

## EL Entry Conditions

* PRD approved
* FSD specs approved
* Architecture & NFRs approved

---

## EL Exit Conditions

* Tasks completed
* Acceptance criteria pass
* Deployment is healthy
* PO accepts the slice

---

## EL → SE Handoff Checklist

Before assigning tasks, EL confirms:

* [ ] Task references PRD and spec section
* [ ] Task is ≤1 week of work
* [ ] Acceptance criteria are testable
* [ ] Rollback path exists
* [ ] Quality gates defined

---

# 5. Software Engineer (SE)

## Purpose

The Software Engineer **faithfully implements defined behaviour**.

They answer **DOES THE SYSTEM ACT EXACTLY AS SPECIFIED**.

---

## SE Responsibilities

* Implement code per spec
* Write tests
* Build immutable artifacts
* Verify behaviour
* Participate in review

SE never:

* changes scope
* guesses intent
* skips tests
* reuses image tags

---

## SE Entry Conditions

* Task exists
* Task references spec
* Architecture constraints known

---

## SE Exit Conditions

* Code matches spec
* Tests pass
* Image built and pushed
* Deployment healthy
* EL approves task

---

## SE → EL Feedback Checklist

If SE encounters issues, they must escalate when:

* [ ] Spec ambiguity exists
* [ ] Acceptance criteria conflict
* [ ] Constraints block implementation
* [ ] Unexpected behaviour is required

SE must stop and escalate — never silently decide.

---

# End‑to‑End Traceability Rule (Global)

At all times, the following must hold:

```
Code → Task → Spec → PRD → BRD → BRF
```

Any artifact that breaks this chain is invalid.

---

## One‑Line Summary

**OKLah succeeds by making intent explicit, behaviour precise, structure safe, delivery disciplined, and execution faithful.**

