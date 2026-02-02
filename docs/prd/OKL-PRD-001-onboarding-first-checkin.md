# OKL-PRD-001 — OKLah — Onboarding + First Check-in
Status: Draft
Derived From: OKL-BRD-001 (BR-OKL-001, BR-OKL-002)
Goal: Get users to first value fast (anonymous onboarding + first check-in)

## 1. Problem / opportunity
Users will abandon if onboarding feels invasive or long. We need a privacy-first path to “first check-in” in under 2 minutes.

## 2. Scope (in)
- Privacy-first intro screen(s)
- Anonymous sign-in (Firebase Anonymous Auth)
- Home screen with one-tap “I’m OK” check-in
- Basic confirmation UI (timestamp + “you’re checked in”)
- First streak initialization (Day 1)

## 3. Out of scope
- Advanced settings
- Nudges/escalation
- Achievements beyond streak start
- Emergency contacts

## 4. User experience requirements
- Show concise privacy statement (no long legal wall)
- One primary CTA: “Start”
- Home screen: single dominant action “I’m OK”
- Confirmation: show last check-in time

## 5. Functional requirements (FR)
FR-001: The system shall allow anonymous account creation automatically on first launch.
FR-002: The system shall record a check-in event when user taps “I’m OK”.
FR-003: The system shall persist last check-in timestamp locally and in backend store.
FR-004: The system shall display last check-in time on home screen.
FR-005: The system shall initialize streak to 1 on first successful check-in.

## 6. Acceptance criteria
AC-001: New install → first check-in can be completed in < 2 minutes.
AC-002: No personal identity field is required (name/phone/email optional but not required).
AC-003: Home displays last check-in time immediately after check-in.
AC-004: Check-in persists across app restarts.

## 7. Analytics (minimum events)
- event: onboarding_start
- event: onboarding_complete
- event: checkin_completed
Properties: user_id (anon), timestamp, app_version
