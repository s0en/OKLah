# OKL-BRD-001 — OKLah — Business Requirements Document (BRD)
Status: Approved
Owner: Product Owner (PO)
Derived from: OKL-BRF-001
Product: OKLah
Date: YYYY-MM-DD

## 1. Purpose & Scope

This Business Requirements Document (BRD) defines the business capabilities, journeys, and rules required to support OKLah’s MVP: a privacy-first, anonymous daily check-in experience.

This document answers WHAT the product must do and WHY, without specifying HOW it is implemented.

It is the authoritative source of Business Rule IDs (BR-OKL-xxx) referenced by all downstream PRDs.

All previously open business decisions have been resolved in this version.

## 2. Actors
- ACT-OKL-001 — End UsermAn individual using OKLah to perform daily check-ins and track personal continuity.
- ACT-OKL-002 — Product Owner (Operational Role)

Responsible for defining product intent, business rules, and success metrics.

## 3. Business Capabilities
- CAP-OKL-001 — Anonymous Access
Enable users to access OKLah without providing personally identifiable information.

- CAP-OKL-002 — Daily Check-in
Allow users to record a simple daily check-in.

- CAP-OKL-003 — Engagement Continuity
Maintain continuity across days, including streaks and missed days.

- CAP-OKL-004 — Engagement Reinforcement
Encourage continued participation through non-punitive feedback and nudges.

- CAP-OKL-005 — Privacy Transparency
Clearly communicate privacy principles and data handling.

-CAP-OKL-006 — Anonymous Data Portability
Allow users to access their anonymous data across devices without converting to an identified account.

## 4. Business Journeys
-JNY-OKL-001 — First-Time User Entry
User installs and opens OKLah for the first time.
Capabilities: CAP-OKL-001, CAP-OKL-005

- JNY-OKL-002 — Daily Engagement
User performs a daily check-in and receives feedback.
Capabilities: CAP-OKL-002, CAP-OKL-003, CAP-OKL-004

- JNY-OKL-003 — Lapsed Engagement
User misses one or more days and returns.
Capabilities: CAP-OKL-003, CAP-OKL-004

- JNY-OKL-004 — Cross-Device Continuity
User restores access to their anonymous data on a new device.
Capabilities: CAP-OKL-006

## 5. Business Rules (Authoritative)

These rules are final and may be referenced by PRDs.

- BR-OKL-001 — Anonymous by Default
Statement
Users SHALL be able to use OKLah without providing personally identifiable information.
Rationale
Trust and low friction are core to adoption.
Applies to
CAP-OKL-001, JNY-OKL-001
Traceability
BRF-001 Constraints

- BR-OKL-002 — Privacy-First Data Minimization
Statement
Only minimal data required for core functionality SHALL be collected and retained.
Rationale
Privacy is a key differentiator.
Applies to
CAP-OKL-001, CAP-OKL-002, CAP-OKL-005
Traceability
BRF-001 Constraints, Risks

- BR-OKL-003 — Single Daily Check-in per Calendar Day
Statement
A user SHALL be allowed at most one check-in per calendar day.
Rationale
Ensures consistency and fairness.
Applies to
CAP-OKL-002, CAP-OKL-003, JNY-OKL-002
Traceability
BRF-001 Goals

- BR-OKL-004 — Base Timezone Anchoring
Statement
The “day” for daily check-in SHALL be anchored to the user’s timezone at the moment of their first successful check-in.
Rationale
Prevents ambiguity across travel and device changes.
Applies to
CAP-OKL-002, CAP-OKL-003
Traceability
BRF-001 User Experience Principles

= BR-OKL-005 — Streak Reset on Missed Day
Statement
A missed daily check-in SHALL reset the user’s streak.
Rationale
Keeps streak logic simple and understandable.
Applies to
CAP-OKL-003, JNY-OKL-003
Traceability
BRF-001 Success Metrics

- BR-OKL-006 — Non-Punitive Engagement Reinforcement
Statement
Feedback and nudges SHALL encourage participation without shaming or negative language.
Rationale
Supports emotional safety.
Applies to
CAP-OKL-004, JNY-OKL-002, JNY-OKL-003
Traceability
BRF-001 §Product Principles

- BR-OKL-007 — Privacy Transparency at First Use
Statement
Users SHALL be informed of privacy principles at first use.
Rationale
Builds trust and informed consent.
Applies to
CAP-OKL-005, JNY-OKL-001
Traceability
BRF-001 Constraints

- BR-OKL-008 — Anonymous Data Portability
Statement
Anonymous user data SHALL be portable across devices without requiring account identification.
Rationale
Supports continuity while preserving anonymity.
Applies to
CAP-OKL-006, JNY-OKL-004
Traceability
BRF-001 Goals, Risks

## 6. Out of Scope (Business-Level)

- Monetization
- Social features
- Clinical diagnosis
- Identity-based accounts

## 7. Success Metrics

- % installs reaching first check-in
- Daily check-in rate
- 7-day streak completion
- Successful anonymous data restorations

## 8. Open Decisions
None. All MVP business decisions resolved.

## 9. Traceability

- BRF: OKL-BRF-001
PRDs:
- OKL-PRD-001 — Onboarding & First Check-in
- OKL-PRD-002 — Missed Check-in & Nudges
- OKL-PRD-003 — Streaks, Achievements & Feedback
- OKL-PRD-004 — Anonymous Data Portability