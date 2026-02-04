# OKL-PRD-002 — Device Porting & Account Continuity

## Status

Draft (Skeleton)

## Parent Initiative

OKL-BRF-001 — OKLah MVP

## Related Documents

* OKL-BRD-001 — Core Check-in & Engagement Capabilities
* OKL-PRD-001 — Anonymous Onboarding & First Check-in

---

## 1. Problem Statement

Users who change devices, reinstall the app, or experience data loss currently lose continuity of their OKLah usage (check-ins, streaks, progress). This creates frustration, reduces trust, and discourages long-term engagement.

OKLah needs a **privacy-respecting, optional mechanism** that allows users to regain continuity **without turning onboarding into mandatory account creation**.

---

## 2. User Intent

As a user,

* I want to switch devices or reinstall the app without losing my progress
* I want to understand what can and cannot be recovered
* I want recovery to be optional and minimally invasive

---

## 3. Goals

* Enable users to regain access to prior OKLah data across devices
* Preserve the privacy-first nature of OKLah
* Avoid introducing friction into MVP onboarding

---

## 4. Non-Goals (Explicit)

This PRD does NOT aim to:

* Require identity at first launch
* Introduce social login or full accounts
* Solve all recovery scenarios (e.g., lost credentials)
* Retroactively recover data from anonymous-only users

---

## 5. In-Scope (High-Level)

* Optional account linking or recovery mechanism
* Clear user communication about recoverability limits
* Recovery entry points outside anonymous onboarding

---

## 6. Out of Scope

* Changes to anonymous onboarding flow (PRD-001)
* UI/UX polish beyond core recovery flows
* Customer support tooling
* Enterprise identity or SSO

---

## 7. Assumptions

* Anonymous onboarding remains the default for MVP
* Some users will accept limited recoverability in exchange for privacy
* Recovery mechanisms may involve credentials or device-bound secrets

---

## 8. Success Metrics

* % of users who successfully recover data after reinstall or device change
* Reduction in drop-off after reinstall
* User-reported trust / clarity around data persistence

---

## 9. Risks & Trade-offs

* Increased complexity vs MVP simplicity
* Privacy perception vs recoverability guarantees
* User confusion if recovery expectations are unclear

---

## 10. Open Questions (To Be Resolved Before Specification)

* What recovery mechanisms are acceptable (email, passcode, device-bound key)?
* How is recovery messaging presented without alarming new users?
* What data is recoverable vs non-recoverable?
* How does recovery interact with streaks and analytics?

---

## 11. Handoff

This PRD is ready for BA specification **after**:

* Recovery intent is approved by PO
* Non-goals are accepted
* Privacy posture is agreed
