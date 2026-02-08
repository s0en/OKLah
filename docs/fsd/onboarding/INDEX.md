# Module: Onboarding

**PRD Reference:** OKL-PRD-001 — Onboarding & First Check-in
**BRD Reference:** OKL-BRD-001

---

## Submodules

| Submodule | Spec Path | Status | Version |
|-----------|-----------|--------|---------|
| Anonymous Onboarding | `anonymous_onboarding/spec.md` | Draft | 1.0 |
| First Check-in | `first_checkin/spec.md` | Draft | 1.0 |

---

## Module Summary

This module covers the new user journey from first app launch through to completion of their first daily check-in. It is decomposed into two submodules:

1. **Anonymous Onboarding** — First-time access detection, privacy disclosure, and anonymous session creation.
2. **First Check-in** — Guided first check-in experience, timezone anchoring, and transition to main app.

---

## Business Rules Covered

| Rule ID | Rule Name | Submodule(s) |
|---------|-----------|--------------|
| BR-OKL-001 | Anonymous by Default | Anonymous Onboarding |
| BR-OKL-002 | Privacy-First Data Minimization | Anonymous Onboarding, First Check-in |
| BR-OKL-003 | Single Daily Check-in per Calendar Day | First Check-in |
| BR-OKL-004 | Base Timezone Anchoring | First Check-in |
| BR-OKL-007 | Privacy Transparency at First Use | Anonymous Onboarding |

---

## Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-06 | BA (via Speckit) | Initial module created with 2 submodules from OKL-PRD-001 |
