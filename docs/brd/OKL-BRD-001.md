# OKL-BRD-001 — OKLah — Business Requirements Document (BRD)
Status: Draft
Derived From: OKL-BRF-001
Owner: Product Owner (PO) / Business Analyst (BA)
Scope: MVP/Beta

## 1. Background & context
OKLah is a privacy-first daily check-in app designed primarily for people living alone. The MVP focuses on anonymous onboarding, a one-tap check-in habit loop, and progressive nudges when check-ins are missed. Gamification (streaks/badges) exists to improve retention without requiring sensitive personal data.

## 2. Business problem
There is no lightweight, privacy-first way for a person living alone to build a consistent “I’m OK” habit that reduces uncertainty without feeling invasive or requiring identity verification.

## 3. Business objectives
- Prove product-market fit signals for a privacy-first daily safety check-in.
- Establish repeatable engagement mechanics (check-in + streak + nudges).
- Produce learning signals (activation/retention/missed-check-in recovery).
- Prepare the product for beta distribution (TestFlight / Google Internal Testing).

## 4. Scope
### In Scope (MVP/Beta)
- Anonymous onboarding
- One-tap daily check-in
- Threshold rules (default + optional per-user settings)
- Missed check-in detection + progressive nudges (push + in-app)
- “I’m OK” confirmation flow after nudge
- Streaks + basic achievements
- Basic analytics/events and reporting readiness

### Out of Scope (MVP/Beta)
- Emergency contact escalation / phone/SMS outreach
- Mandatory identity (name/phone/address) requirements
- Raw GPS storage by default
- Partner/healthcare integrations

## 5. Stakeholders & roles
### Internal
- PO: Owns BRF/BRD/PRD priorities and scope
- BA: Owns requirements, acceptance criteria, clarify loops
- SA: Owns architecture, NFRs, ADR decisions
- EL: Owns task breakdown and delivery plan
- SE: Builds, tests, instruments, ships beta

### External
- End Users: people living alone, privacy-conscious users
- Future (Phase 2+): caregivers, emergency contacts

## 6. Users, needs, and constraints
### Primary user: End user
Needs:
- Quick and private onboarding
- A daily habit that is effortless
- Clear, non-intrusive reminders if they forget
Constraints:
- Privacy-first defaults
- No mandatory personal data in MVP

### System constraints
- Minimize backend complexity (Firebase-first approach acceptable)
- Must support push notifications reliably
- Must include basic instrumentation for learning

## 7. Capabilities (what the business needs the product to do)
C1. Privacy-first onboarding (anonymous)
C2. Daily check-in capture (one tap)
C3. Habit reinforcement (streaks/achievements)
C4. Missed check-in detection (rule-based)
C5. Progressive nudges (push + in-app)
C6. Confirmation flow (“I’m OK”)
C7. Preferences & controls (thresholds, notification controls)
C8. Analytics & reporting readiness (events, funnels)

## 8. High-level user journeys
### J1 — Anonymous onboarding → first check-in
1) User installs OKLah
2) Opens app → sees privacy-fi
