# Tasks: Anonymous Onboarding

**Module:** Onboarding
**Submodule:** Anonymous Onboarding
**Spec:** `docs/fsd/onboarding/anonymous_onboarding/spec.md` (v1.0, post-clarify)
**Plan:** `docs/fsd/onboarding/anonymous_onboarding/plan.md` (v2.0)
**Version:** 1.0
**Last Updated:** 2026-02-07

---

## Prerequisites

> These tasks must be completed before any anonymous onboarding tasks can start. They are tracked here for visibility but may be owned by other workstreams.

- [ ] **P-01** — Flutter app scaffold created at `apps/mobile/` (entry point, routing framework, theme, forui integration)
  - Plan ref: D-01
- [ ] **P-02** — Firebase SDK integrated (`firebase_core`, `firebase_auth` packages added to `apps/mobile/pubspec.yaml`, `Firebase.initializeApp()` in main)
  - Plan ref: D-02
- [ ] **P-03** — Local storage solution available (`shared_preferences` or `flutter_secure_storage` added to `apps/mobile/pubspec.yaml`)
  - Plan ref: D-03

---

## Task Group 1: 3-State Routing Gate

> Plan ref: IU-01 | Spec ref: §4.1, §5, VR-AO-002, E-AO-004

- [ ] **T-01** — Create onboarding routing service
  - Create `apps/mobile/lib/features/onboarding/services/onboarding_router.dart`
  - Implement logic that checks two signals at app launch:
    1. Firebase Auth state (`FirebaseAuth.instance.currentUser`)
    2. Completion flag from local storage (`onboarding_complete`)
  - Return one of 3 route destinations:
    - `privacyDisclosure` — no session exists (first time)
    - `firstCheckin` — session exists + completion flag is false/missing
    - `mainExperience` — session exists + completion flag is true
  - Handle edge case: flag is `true` but no Firebase Auth session → treat as first time
  - Spec trace: §4.1 invariant, E-AO-004
  - **Does NOT write any flags** (read-only)

- [ ] **T-02** — Integrate routing gate into app startup
  - Wire `onboarding_router` into app's root widget / router configuration at `apps/mobile/lib/app.dart` (or equivalent)
  - Ensure gate runs before any screen is rendered
  - Spec trace: §4.1, VR-AO-002

- [ ] **T-03** — Unit test: routing gate — 4 scenarios
  - File: `apps/mobile/test/features/onboarding/services/onboarding_router_test.dart`
  - Test 1: No session + no flag → returns `privacyDisclosure`
  - Test 2: Session exists + flag `true` → returns `mainExperience`
  - Test 3: Session exists + flag `false`/missing → returns `firstCheckin`
  - Test 4: Flag `true` + no session → returns `privacyDisclosure` (recovery)
  - Mock `FirebaseAuth` and `SharedPreferences`
  - Plan ref: §7.1 rows 1–4

---

## Task Group 2: Privacy Disclosure Screen

> Plan ref: IU-02 | Spec ref: §4.2, VR-AO-001, AC-AO-02, AC-AO-03

- [ ] **T-04** — Create privacy disclosure screen widget
  - Create `apps/mobile/lib/features/onboarding/screens/privacy_disclosure_screen.dart`
  - Full-screen layout with 3 content points (placeholder text until PO provides final copy):
    1. OKLah does not collect personal information.
    2. Data is stored locally on the device by default.
    3. The experience is anonymous by design.
  - Single "Continue" CTA button
  - Use `forui` components per PROJECT-CONFIG.md
  - Spec trace: §4.2 content requirements

- [ ] **T-05** — Block passive dismissal
  - Override `WillPopScope` / `PopScope` to prevent system back button and swipe-back from dismissing the screen
  - Ensure the ONLY way to proceed is the "Continue" button
  - Spec trace: §4.2 behavioral rules, VR-AO-001

- [ ] **T-06** — Wire acknowledgement callback
  - On "Continue" tap: invoke a callback/event that triggers anonymous session creation (T-08)
  - Do NOT persist any acknowledgement state separately (per E-AO-002 resolution: acknowledgement is not stored independently)
  - Spec trace: §4.2, E-AO-002

- [ ] **T-07** — Unit/widget test: privacy disclosure screen
  - File: `apps/mobile/test/features/onboarding/screens/privacy_disclosure_screen_test.dart`
  - Test 1: Screen renders all 3 content points
  - Test 2: "Continue" button is present and fires callback on tap
  - Test 3: System back button does NOT navigate away
  - Test 4: No session or data is created before "Continue" is tapped
  - Plan ref: §7.1 rows 5–6

---

## Task Group 3: Anonymous Session Creation

> Plan ref: IU-03 | Spec ref: §4.3, §4.4, AC-AO-04, E-AO-002, E-AO-003

- [ ] **T-08** — Create anonymous auth service
  - Create `apps/mobile/lib/features/onboarding/services/anonymous_auth_service.dart`
  - Method: `Future<User> createAnonymousSession()`
  - Calls `FirebaseAuth.instance.signInAnonymously()`
  - Returns the `User` on success
  - Throws a typed error on failure (network error, Firebase error)
  - **Does NOT set `onboarding_complete` flag** (owned by `first_checkin` submodule per Spec §4.4)
  - Spec trace: §4.3, §4.4, BR-OKL-001

- [ ] **T-09** — (Optional) Create Firestore user document on session creation
  - After successful `signInAnonymously()`, create a minimal `/users/{uid}` document in Firestore
  - Document should contain only what downstream submodules need (e.g., `createdAt` timestamp)
  - No PII fields (VR-AO-003)
  - Depends on: Plan OI-04 decision. If deferred, skip this task.
  - Spec trace: BR-OKL-002

- [ ] **T-10** — Show loading state during session creation
  - After user taps "Continue" on disclosure, show a loading indicator while `signInAnonymously()` is in progress
  - Prevent double-tap / multiple submissions
  - Spec trace: §4.3

- [ ] **T-11** — Unit test: anonymous auth service
  - File: `apps/mobile/test/features/onboarding/services/anonymous_auth_service_test.dart`
  - Test 1: `signInAnonymously()` success → returns User, does NOT write completion flag
  - Test 2: `signInAnonymously()` failure → throws typed error
  - Mock `FirebaseAuth`
  - Plan ref: §7.1 rows 7–8

---

## Task Group 4: Transition to First Check-in

> Plan ref: IU-04 | Spec ref: §4.4

- [ ] **T-12** — Navigate to first check-in after session creation
  - After successful session creation, navigate to the first check-in screen
  - Use a named route or equivalent routing mechanism
  - If `first_checkin` submodule is not yet implemented, navigate to a stub/placeholder screen
  - Navigation should be a replacement (not push) — user should not be able to go "back" to disclosure
  - Spec trace: §4.4

- [ ] **T-13** — Create stub first check-in screen (if needed)
  - Create `apps/mobile/lib/features/onboarding/screens/first_checkin_stub_screen.dart`
  - Simple placeholder screen showing "First check-in — coming soon"
  - Remove this stub when `onboarding/first_checkin` is implemented
  - Spec trace: §4.4, Plan D-04

---

## Task Group 5: Error Handling

> Plan ref: IU-06 | Spec ref: §7 (E-AO-001 through E-AO-004)

- [ ] **T-14** — Handle session creation failure (network / Firebase error)
  - If `signInAnonymously()` fails: show a user-friendly error on the disclosure screen
  - Include a "Try Again" button that re-invokes session creation
  - User should NOT be left on a blank or broken screen
  - Spec trace: E-AO-003

- [ ] **T-15** — Handle force-close during disclosure (E-AO-001)
  - Verify that since no state is written before session creation, a force-close during disclosure results in a clean re-show on next launch
  - This is a behavioral verification, not new code — the routing gate (T-01) handles it
  - Spec trace: E-AO-001

- [ ] **T-16** — Handle force-close during session creation (E-AO-002)
  - Verify that if the user closes the app after tapping "Continue" but before `signInAnonymously()` completes, the next launch re-enters from the disclosure screen (no partial state persisted)
  - This is a behavioral verification — routing gate (T-01) detects no session and re-routes
  - Spec trace: E-AO-002

- [ ] **T-17** — Widget test: error handling scenarios
  - File: `apps/mobile/test/features/onboarding/screens/privacy_disclosure_error_test.dart`
  - Test 1: Session creation fails → error message displayed, "Try Again" button shown
  - Test 2: "Try Again" tapped → session creation re-invoked
  - Test 3: Session creation succeeds on retry → navigates to first check-in
  - Plan ref: §7.2 row 6

---

## Task Group 6: Analytics Events

> Plan ref: IU-05 | Spec ref: §9

- [ ] **T-18** — Create onboarding analytics service
  - Create `apps/mobile/lib/features/onboarding/services/onboarding_analytics.dart`
  - Methods to emit each of the 5 events:
    1. `logOnboardingStarted()` — fired in routing gate when first-time user detected
    2. `logPrivacyDisclosureShown()` — fired when disclosure screen is displayed
    3. `logPrivacyDisclosureAcknowledged()` — fired when user taps "Continue"
    4. `logAnonymousSessionCreated()` — fired after `signInAnonymously()` succeeds
    5. `logOnboardingCompleted()` — fired after session creation + just before handoff to first check-in
  - Use `firebase_analytics` package
  - Spec trace: §9

- [ ] **T-19** — Wire analytics events into onboarding flow
  - Integrate calls to `onboarding_analytics` at the appropriate points:
    - `onboarding_started`: in routing gate (T-01/T-02) when `privacyDisclosure` route is selected
    - `privacy_disclosure_shown`: in `privacy_disclosure_screen` `initState` / `onMount`
    - `privacy_disclosure_acknowledged`: in "Continue" button handler (T-06)
    - `anonymous_session_created`: in auth service callback after success (T-08)
    - `onboarding_completed`: just before navigation to first check-in (T-12)
  - Spec trace: §9

- [ ] **T-20** — Unit test: analytics events
  - File: `apps/mobile/test/features/onboarding/services/onboarding_analytics_test.dart`
  - Test: Each method calls `FirebaseAnalytics.logEvent` with the correct event name
  - Mock `FirebaseAnalytics`
  - Plan ref: §7.1 row 9

---

## Task Group 7: Integration / Widget Tests

> Plan ref: §7.2

- [ ] **T-21** — Widget test: full happy path
  - File: `apps/mobile/test/features/onboarding/integration/onboarding_flow_test.dart`
  - Scenario: Launch (no session) → disclosure shown → tap "Continue" → session created → navigates to first check-in screen
  - Verify all 5 analytics events fire in order
  - Mock Firebase Auth + SharedPreferences
  - Plan ref: §7.2 row 1; covers AC-AO-01 through AC-AO-04

- [ ] **T-22** — Widget test: re-launch with session but no check-in
  - Same file as T-21
  - Scenario: Launch with existing Firebase Auth session + no completion flag → skips disclosure → shows first check-in screen
  - Plan ref: §7.2 row 2; covers AC-AO-05

- [ ] **T-23** — Widget test: re-launch after full completion
  - Same file as T-21
  - Scenario: Launch with existing Firebase Auth session + completion flag `true` → goes to main experience
  - Plan ref: §7.2 row 3; covers AC-AO-05

- [ ] **T-24** — Widget test: force-close during disclosure
  - Same file as T-21
  - Scenario: Simulate launch with no session/no flag → disclosure shown → "simulate re-launch" (reset state, re-run gate) → disclosure shown again
  - Plan ref: §7.2 row 4; covers E-AO-001

- [ ] **T-25** — Widget test: force-close during session creation
  - Same file as T-21
  - Scenario: Launch → disclosure → acknowledge → mock `signInAnonymously()` to never complete → "simulate re-launch" (no session persisted) → disclosure shown again
  - Plan ref: §7.2 row 5; covers E-AO-002

---

## Task Group 8: Documentation Sync

- [ ] **T-26** — Update spec if implementation diverges
  - After completing all implementation tasks, review `docs/fsd/onboarding/anonymous_onboarding/spec.md`
  - If any implemented behavior differs from the spec (e.g., due to technical constraints discovered during implementation), update the spec to reflect the actual behavior
  - Increment spec version in the Change Log
  - Spec trace: Constitution Principle II (FSD-Speckit Bidirectional Sync)

- [ ] **T-27** — Update plan if implementation diverges
  - After completing all implementation tasks, review `docs/fsd/onboarding/anonymous_onboarding/plan.md`
  - Update any assumptions, open items, or architecture decisions that changed during implementation
  - Increment plan version in the Change Log

- [ ] **T-28** — Update module INDEX.md
  - Update `docs/fsd/onboarding/INDEX.md` — change Anonymous Onboarding status from "Draft" to "Implemented"
  - Spec trace: Constitution Principle II

---

## Definition of Done

All of the following must be true before this submodule is considered complete:

### Code

- [ ] All tasks T-01 through T-20 are implemented (T-09 conditional on OI-04 decision)
- [ ] Code compiles with zero errors and zero warnings
- [ ] No PII is collected or stored at any point during onboarding (AC-AO-06)
- [ ] The completion flag is NOT written by any code in this submodule (Spec §4.4)

### Tests

- [ ] All unit tests pass (T-03, T-07, T-11, T-17, T-20)
- [ ] All widget/integration tests pass (T-21 through T-25)
- [ ] 3-state routing gate handles all 4 launch scenarios correctly
- [ ] Privacy disclosure blocks passive dismissal in all tests

### Acceptance Criteria (from Spec §8)

- [ ] AC-AO-01: New user reaches first check-in without providing PII
- [ ] AC-AO-02: Privacy principles communicated before any data is created
- [ ] AC-AO-03: Explicit acknowledgement required; passive dismissal blocked
- [ ] AC-AO-04: Anonymous session created only after acknowledgement
- [ ] AC-AO-05: Returning users skip disclosure; session-but-no-checkin users go to first check-in
- [ ] AC-AO-06: No PII collected at any point

### Analytics

- [ ] All 5 analytics events fire at the correct points in the flow (T-18, T-19, T-20)

### Documentation

- [ ] Spec updated if implementation diverged (T-26)
- [ ] Plan updated if implementation diverged (T-27)
- [ ] Module INDEX.md updated (T-28)

---

## Task Summary

| Group | Tasks | Count | Depends On |
|-------|-------|-------|------------|
| Prerequisites | P-01, P-02, P-03 | 3 | External |
| 1. Routing Gate | T-01, T-02, T-03 | 3 | P-01, P-02, P-03 |
| 2. Privacy Disclosure | T-04, T-05, T-06, T-07 | 4 | Group 1 |
| 3. Session Creation | T-08, T-09, T-10, T-11 | 4 | Group 2 |
| 4. Transition | T-12, T-13 | 2 | Group 3 |
| 5. Error Handling | T-14, T-15, T-16, T-17 | 4 | Groups 2–4 |
| 6. Analytics | T-18, T-19, T-20 | 3 | Groups 1–4 |
| 7. Integration Tests | T-21, T-22, T-23, T-24, T-25 | 5 | Groups 1–6 |
| 8. Documentation | T-26, T-27, T-28 | 3 | Groups 1–7 |

**Total: 3 prerequisites + 28 tasks**

---

## Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-07 | Engineering Lead (via Speckit) | Initial task list generated from spec v1.0 (post-clarify) + plan v2.0 |
