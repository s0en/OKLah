# OKL-PRD-002 — OKLah — Missed Check-in + Nudges + “I’m OK” Recovery
Status: Draft
Derived From: OKL-BRD-001 (BR-OKL-003, BR-OKL-004, BR-OKL-005)
Goal: Close the safety loop when users forget

## 1. Problem / opportunity
The product’s core value is reduced uncertainty: if a user forgets, the system nudges them and allows a simple recovery confirmation.

## 2. Scope (in)
- Default threshold rule (e.g., missed check-in for 1 day triggers nudge) — configurable later
- Scheduled job / logic to detect missed check-ins
- Push notification nudge (FCM)
- In-app banner prompt when app opens after missed period
- Recovery flow: “I’m OK” confirmation

## 3. Out of scope
- Emergency contact escalation
- SMS/Email outreach
- Complex multi-step verification

## 4. Functional requirements (FR)
FR-101: The system shall compute “days since last check-in” daily (or on app open).
FR-102: The system shall flag a user as “missed” when threshold is reached.
FR-103: The system shall send a push nudge to flagged users (if push enabled).
FR-104: The system shall show an in-app banner if user is flagged and opens the app.
FR-105: The system shall provide a recovery confirmation action that records a new check-in.
FR-106: The system shall rate-limit nudges (e.g., max 1 per day) to avoid spam.

## 5. Acceptance criteria
AC-101: When threshold is reached, a push is sent (if user opted-in or OS allows).
AC-102: If user ignores push, they see an in-app banner next open.
AC-103: Recovery flow records a new check-in and clears “missed” state.
AC-104: Nudge rate limiting works (no repeated spam within a day).

## 6. Analytics (minimum events)
- event: missed_checkin_flagged
- event: nudge_sent
- event: nudge_opened
- event: recovery_confirmed
Properties: threshold_days, channel (push/inapp), timestamp
