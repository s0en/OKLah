OKL-PRD-002 — Missed Check-in & Nudges

Status: Draft
Owner: Product Owner (PO)
Derived from: OKL-BRD-001
Related Business Rules: BR-OKL-003, BR-OKL-004, BR-OKL-005, BR-OKL-006
Related Capabilities: CAP-OKL-003, CAP-OKL-004
Date: YYYY-MM-DD

## 1. Problem Statement

Users may miss daily check-ins due to routine disruption.
Without thoughtful handling, missed days can lead to disengagement or discouragement.

## 2. User Intent

As a returning user,
I want gentle reminders when I miss a check-in,
so that I feel encouraged—not punished—to continue.

## 3. Goals

- G-01 Detect missed daily check-ins.
- G-02 Encourage re-engagement in a non-punitive way.
- G-03 Maintain trust and emotional safety.

## 4. Non-Goals

- NG-01 Guaranteeing streak preservation.
- NG-02 Real-time notifications.
- NG-03 Personalization beyond basic timing.

## 5. In Scope

- Detection of missed check-ins.
- Business rules for re-engagement nudges.
- Messaging tone aligned with product principles.

## 6. Out of Scope

- Achievement or reward logic.
- Cross-device behavior.
- Advanced notification settings.

## 7. Success Metrics

- % of lapsed users returning after a missed day.
- Nudge engagement rate.
- User feedback on reminder tone.

## 8. Constraints (Inherited)

- One check-in per calendar day (BR-OKL-003).
- Base timezone anchoring (BR-OKL-004).
- Streak resets after missed days (BR-OKL-005).
- Non-punitive engagement (BR-OKL-006).

# 9. Risks & Trade-offs

- R-01 Nudges may feel intrusive.
- R-02 Too few nudges may be ineffective.

Trade-off: Favor opt-in encouragement over aggressive reminders.

## 10. Open Decisions

None.

## 11. FSD Decomposition (authoritative)

This PRD SHALL be decomposed into the following FSD submodules:

- engagement/missed_checkin_detection
Rationale: Miss detection is rule-based and independent of user messaging.

- engagement/nudge_delivery
Rationale: Nudge behavior, timing, and tone evolve independently from detection logic.

Decomposition rationale summary
Separating detection from delivery improves testability and allows experimentation without destabilizing core rules.

## 12. Acceptance Boundary

- BA derives FSD only.
- No notification delivery mechanisms or UX flows defined here.