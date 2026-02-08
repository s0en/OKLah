# Tasks: First Check-in

**Module:** Onboarding
**Submodule:** First Check-in
**Spec:** `docs/fsd/onboarding/first_checkin/spec.md` (v1.2, post-clarify)
**Plan:** `docs/fsd/onboarding/first_checkin/plan.md` (v1.0)
**Version:** 1.0
**Last Updated:** 2026-02-07

---

## Prerequisites

> These tasks must be completed before any first check-in tasks can start. They are tracked here for visibility but may be owned by other workstreams.

- [ ] **P-01** — Flutter app scaffold created at `apps/mobile/` (entry point, routing framework, theme, forui integration)
  - Plan ref: D-01
- [ ] **P-02** — Firebase SDK integrated (`firebase_core`, `firebase_auth`, `cloud_firestore`, `cloud_functions` packages added to `apps/mobile/pubspec.yaml`, `Firebase.initializeApp()` in main)
  - Plan ref: D-02
- [ ] **P-03** — Local storage solution available (`shared_preferences` or `flutter_secure_storage` added to `apps/mobile/pubspec.yaml`)
  - Plan ref: D-03
- [ ] **P-04** — `onboarding/anonymous_onboarding` routing gate implemented (this screen is a destination of the 3-state gate)
  - Plan ref: D-04
- [ ] **P-05** — `recordCheckIn` Cloud Function deployable (skeleton exists at `services/firebase/functions/src/index.ts`)
  - Plan ref: D-05

---

## Task Group 1: Cloud Function Update

> Plan ref: IU-03 | Spec ref: §4.3 steps 1–3, BR-OKL-004

- [ ] **T-01** — Update `recordCheckIn` to accept and persist timezone
  - File: `services/firebase/functions/src/index.ts`
  - Accept an optional `timezone` field in `data` parameter
  - If `timezone` is provided, write it to `/users/{uid}.baseTimezone` using `set` with `merge: true` (handles both create and update cases — Plan OI-05)
  - The timezone write is one-time; if `baseTimezone` already exists, do not overwrite
  - Spec trace: BR-OKL-004, §4.3 step 2

- [ ] **T-02** — Add `source` field distinction in `recordCheckIn`
  - File: `services/firebase/functions/src/index.ts`
  - Accept an optional `source` field in `data` parameter (e.g., `"first_checkin"`, `"tap"`)
  - Default to `"tap"` if not provided (backward compatibility)
  - Write `source` to the check-in document in `/checkins/{docId}`
  - Plan ref: §4.1 (source distinction)

- [ ] **T-03** — Unit test: Cloud Function timezone + source
  - File: `services/firebase/functions/src/__tests__/recordCheckIn.test.ts` (or equivalent)
  - Test 1: `recordCheckIn` with `timezone` field → persists to `/users/{uid}.baseTimezone`
  - Test 2: `recordCheckIn` without `timezone` field → no write to `/users/{uid}.baseTimezone`
  - Test 3: `recordCheckIn` with `source: "first_checkin"` → stored in check-in doc
  - Test 4: `recordCheckIn` without `source` → defaults to `"tap"`
  - Test 5: `recordCheckIn` without auth → rejects with `unauthenticated`
  - Test 6: `recordCheckIn` with existing `baseTimezone` → does not overwrite
  - Use Firebase Emulator Suite or `firebase-functions-test`
  - Plan ref: §7.1 rows 12–13

---

## Task Group 2: First Check-in Screen

> Plan ref: IU-01 | Spec ref: §4.2, AC-FC-01, AC-FC-02, US-FC-003, E-FC-005

- [ ] **T-04** — Create first check-in screen widget
  - Create `apps/mobile/lib/features/onboarding/screens/first_checkin_screen.dart`
  - Full-screen layout with:
    1. Welcoming guidance text (placeholder until PO provides final copy) explaining what a "check-in" means
    2. Prominent "I'm OK" CTA button (primary action, unambiguous)
    3. Loading state indicator (shown while Cloud Function call is in progress)
  - Use `forui` components per PROJECT-CONFIG.md
  - Spec trace: §4.2, US-FC-003, AC-FC-01

- [ ] **T-05** — Block passive dismissal on first check-in screen
  - Override `PopScope` to prevent system back button and swipe-back from navigating away
  - The user must complete the check-in to proceed (E-FC-005 — session exists, so re-entry shows this screen again anyway)
  - Spec trace: E-FC-005

- [ ] **T-06** — Implement double-tap prevention
  - After the user taps the CTA button, immediately disable the button to prevent multiple submissions
  - Re-enable only on error (to allow retry)
  - Spec trace: BR-OKL-003 (idempotency), Plan NFR

- [ ] **T-07** — Widget test: first check-in screen
  - File: `apps/mobile/test/features/onboarding/screens/first_checkin_screen_test.dart`
  - Test 1: Screen renders guidance text and CTA button
  - Test 2: CTA button is present, prominent, and fires callback on tap
  - Test 3: System back button does NOT navigate away
  - Test 4: After CTA tap, button is disabled (double-tap prevention)
  - Test 5: Loading indicator is shown after CTA tap
  - Plan ref: §7.1 row 6, §7.2 rows 1–2

---

## Task Group 3: Check-in Recording Service

> Plan ref: IU-02 | Spec ref: §4.3, VR-FC-001, VR-FC-004, AC-FC-08

- [ ] **T-08** — Create check-in recording service
  - Create `apps/mobile/lib/features/onboarding/services/checkin_recording_service.dart`
  - Method: `Future<void> recordFirstCheckin()`
  - Implementation:
    1. Validate Firebase Auth session exists (VR-FC-001); throw if not
    2. Capture current timestamp
    3. Capture device timezone as IANA identifier (`DateTime.now().timeZoneName`)
    4. Call `recordCheckIn` Cloud Function with `{ timezone: <tz>, source: "first_checkin" }`
    5. On success → write `onboarding_complete = true` to local storage (SharedPreferences)
    6. On failure → throw typed error (do NOT write flag)
  - Write ordering: server-first, then local flag (Plan §4.2)
  - This service is the **sole writer** of the `onboarding_complete` flag (Spec §4.3 step 5, §4.5)
  - Spec trace: §4.3 steps 1–5, VR-FC-004

- [ ] **T-09** — Handle timezone detection failure (E-FC-003)
  - In `checkin_recording_service.dart`, if `DateTime.now().timeZoneName` returns an unexpected or empty value:
    - Use `"UTC"` as fallback
    - Log an analytics event (`timezone_fallback_used` or similar)
  - The check-in MUST still succeed (Spec: "Record the check-in anyway")
  - Spec trace: E-FC-003, VR-FC-003

- [ ] **T-10** — Unit test: check-in recording service
  - File: `apps/mobile/test/features/onboarding/services/checkin_recording_service_test.dart`
  - Test 1: No auth session → throws error, does NOT call Cloud Function
  - Test 2: Auth session exists → calls `recordCheckIn` with correct timestamp + timezone
  - Test 3: `recordCheckIn` success → `onboarding_complete` flag set to `true` in SharedPreferences
  - Test 4: `recordCheckIn` success → flag NOT set until after function returns (write ordering)
  - Test 5: `recordCheckIn` failure → error thrown, flag NOT set, no side effects
  - Test 6: Timezone unavailable → UTC fallback used, function still called
  - Test 7: Midnight boundary (E-FC-006) → timestamp at tap moment determines calendar day
  - Mock `FirebaseAuth`, `HttpsCallable`, `SharedPreferences`
  - Plan ref: §7.1 rows 1–5, 7–8, 11

---

## Task Group 4: E-FC-002 Recovery Logic

> Plan ref: IU-04 | Spec ref: E-FC-002, VR-FC-002

- [ ] **T-11** — Create recovery check on screen load
  - In `first_checkin_screen.dart` (or a dedicated service), on screen initialization:
    1. Query Firestore `/checkins` for the current user's UID + today's date (per device timezone)
    2. If a check-in exists for today:
       a. Read `onboarding_complete` from local storage
       b. If flag is `false`/missing → set flag to `true` (recovery write)
       c. Show "already checked in" message (non-punitive, per BR-OKL-006)
       d. Transition to main experience
    3. If no check-in exists → show normal first check-in screen
  - This handles partial-persist crash (server wrote check-in but app crashed before local flag write)
  - Spec trace: E-FC-002, VR-FC-002

- [ ] **T-12** — Unit test: E-FC-002 recovery logic
  - File: `apps/mobile/test/features/onboarding/services/checkin_recovery_test.dart`
  - Test 1: Existing check-in found + flag missing → flag set to `true` + "already checked in" returned
  - Test 2: Existing check-in found + flag already `true` → "already checked in" returned, no redundant flag write
  - Test 3: No existing check-in found → normal screen flow (no recovery)
  - Test 4: Firestore query fails (network error) → fall through to normal screen (safe default)
  - Mock `FirebaseFirestore`, `SharedPreferences`
  - Plan ref: §7.1 rows 9–10

---

## Task Group 5: Confirmation & Transition

> Plan ref: IU-05 | Spec ref: §4.4, AC-FC-05, AC-FC-06

- [ ] **T-13** — Create confirmation view
  - In `apps/mobile/lib/features/onboarding/screens/first_checkin_screen.dart` (or a separate widget)
  - After successful check-in recording:
    1. Display a clear, positive confirmation message (placeholder text until PO provides final copy)
    2. Message should be welcoming and affirming (aligned with BR-OKL-006 spirit)
    3. After a brief display (or user interaction), transition to main experience
  - Spec trace: §4.4, AC-FC-05

- [ ] **T-14** — Navigate to main experience after confirmation
  - Use replacement navigation (not push) — user should NOT be able to go "back" to the first check-in screen
  - If the main experience screen is not yet implemented, navigate to a stub/placeholder
  - Spec trace: §4.4, AC-FC-06

- [ ] **T-15** — Create stub main experience screen (if needed)
  - Create `apps/mobile/lib/features/main/screens/main_experience_stub_screen.dart`
  - Simple placeholder showing "Welcome to OKLah — coming soon"
  - Remove this stub when the main experience is implemented
  - Plan ref: D-07, OI-06

---

## Task Group 6: Error Handling

> Plan ref: IU-06 | Spec ref: §7 (E-FC-001 through E-FC-006)

- [ ] **T-16** — Handle Cloud Function failure (network / server error)
  - If `recordCheckIn` Cloud Function call fails:
    1. Show a user-friendly error message on the first check-in screen
    2. Re-enable the CTA button
    3. Include a "Try Again" option (retry re-invokes recording)
    4. Do NOT show success confirmation
    5. Do NOT write `onboarding_complete` flag
  - Spec trace: E-FC-004, VR-FC-004

- [ ] **T-17** — Handle force-close during recording (E-FC-001)
  - Verify that since the routing gate detects "session exists + no flag" → routes back to first check-in screen:
    - If check-in was persisted server-side → E-FC-002 recovery (T-11) handles it
    - If check-in was NOT persisted → normal first check-in screen shown
  - This is primarily a behavioral verification (no new code beyond T-11), confirming the routing gate + recovery logic work together
  - Spec trace: E-FC-001

- [ ] **T-18** — Handle midnight boundary (E-FC-006)
  - Ensure the timestamp is captured at the moment the user taps the CTA (not when the screen loaded or when the Cloud Function responds)
  - This is handled by T-08 implementation; this task is a verification that the timestamp logic is correct
  - Spec trace: E-FC-006

- [ ] **T-19** — Widget test: error handling scenarios
  - File: `apps/mobile/test/features/onboarding/screens/first_checkin_error_test.dart`
  - Test 1: Cloud Function fails → error message displayed, CTA re-enabled
  - Test 2: "Try Again" tapped → Cloud Function re-invoked
  - Test 3: Cloud Function succeeds on retry → confirmation shown, navigates to main
  - Test 4: Cloud Function fails → `onboarding_complete` flag remains unset
  - Plan ref: §7.2 rows 3–4

---

## Task Group 7: Analytics Events

> Plan ref: IU-07 | Spec ref: §9

- [ ] **T-20** — Create first check-in analytics service
  - Create `apps/mobile/lib/features/onboarding/services/first_checkin_analytics.dart`
  - Methods to emit each of the 6 events:
    1. `logFirstCheckinScreenShown()` — fired when the first check-in screen is displayed
    2. `logFirstCheckinAttempted()` — fired when the user taps the CTA
    3. `logFirstCheckinCompleted()` — fired after `recordCheckIn` succeeds + flag is set
    4. `logFirstCheckinFailed()` — fired when `recordCheckIn` fails
    5. `logFirstCheckinTimeElapsed(Duration elapsed)` — fired with the duration from `onboarding_completed` to `first_checkin_completed`
    6. `logTimezoneAnchored(String timezone, {bool isFallback = false})` — fired after timezone is persisted; includes whether UTC fallback was used
  - Use `firebase_analytics` package
  - Spec trace: §9

- [ ] **T-21** — Wire analytics events into first check-in flow
  - Integrate calls to `first_checkin_analytics` at the appropriate points:
    - `first_checkin_screen_shown`: in first check-in screen `initState` / `onMount`
    - `first_checkin_attempted`: in CTA button handler (before Cloud Function call)
    - `first_checkin_completed`: after flag write succeeds (T-08 step 5)
    - `first_checkin_failed`: in error handler (T-16)
    - `first_checkin_time_elapsed`: compute delta between `onboarding_completed` event timestamp and `first_checkin_completed`
    - `timezone_anchored`: after successful recording, with the captured timezone
  - Spec trace: §9

- [ ] **T-22** — Unit test: analytics events
  - File: `apps/mobile/test/features/onboarding/services/first_checkin_analytics_test.dart`
  - Test: Each method calls `FirebaseAnalytics.logEvent` with the correct event name and parameters
  - Mock `FirebaseAnalytics`
  - Plan ref: §7.1 row (analytics)

---

## Task Group 8: Integration / Widget Tests

> Plan ref: §7.2

- [ ] **T-23** — Widget test: full happy path
  - File: `apps/mobile/test/features/onboarding/integration/first_checkin_flow_test.dart`
  - Scenario: Screen shown → tap CTA → loading → Cloud Function succeeds → flag set → confirmation → navigates to main experience
  - Verify:
    - CTA button is disabled during loading
    - Confirmation message is displayed
    - Navigation uses replacement (no back)
    - `onboarding_complete` flag is `true` after flow completes
  - Mock Cloud Functions + SharedPreferences
  - Plan ref: §7.2 row 1; covers AC-FC-01, AC-FC-05, AC-FC-06, AC-FC-08

- [ ] **T-24** — Widget test: back button blocked
  - Same file as T-23
  - Scenario: Screen shown → system back button pressed → screen remains (no navigation)
  - Plan ref: §7.2 row 2; covers E-FC-005

- [ ] **T-25** — Widget test: recording failure and retry
  - Same file as T-23
  - Scenario: Screen shown → tap CTA → Cloud Function fails → error shown → CTA re-enabled → tap again → succeeds → confirmation → main experience
  - Plan ref: §7.2 row 3; covers E-FC-004

- [ ] **T-26** — Widget test: E-FC-002 recovery flow
  - Same file as T-23
  - Scenario: Screen opens → recovery check finds existing check-in + no flag → flag set → "already checked in" message → transition to main experience
  - Plan ref: §7.2 row 4; covers E-FC-002

- [ ] **T-27** — Widget test: all analytics events fire
  - Same file as T-23
  - Scenario: Full happy path flow → verify all 6 analytics events are emitted in correct order
  - Plan ref: §7.2 row 5; covers §9

- [ ] **T-28** — Widget test: cross-submodule flow (with anonymous_onboarding)
  - Same file as T-23 (or separate cross-submodule test file)
  - Scenario: Full flow from anonymous onboarding handoff → first check-in screen → check-in → confirmation → main experience
  - Verify routing gate correctly routes to first check-in after session creation
  - Mock Firebase Auth + Cloud Functions + SharedPreferences
  - Plan ref: §7.2 row 6; covers end-to-end across both submodules

---

## Task Group 9: Documentation Sync

- [ ] **T-29** — Update spec if implementation diverges
  - After completing all implementation tasks, review `docs/fsd/onboarding/first_checkin/spec.md`
  - If any implemented behavior differs from the spec (e.g., due to technical constraints discovered during implementation), update the spec to reflect the actual behavior
  - Increment spec version in the Change Log
  - Spec trace: Constitution Principle II (FSD-Speckit Bidirectional Sync)

- [ ] **T-30** — Update plan if implementation diverges
  - After completing all implementation tasks, review `docs/fsd/onboarding/first_checkin/plan.md`
  - Update any assumptions, open items, or architecture decisions that changed during implementation
  - Increment plan version in the Change Log

- [ ] **T-31** — Update module INDEX.md
  - Update `docs/fsd/onboarding/INDEX.md` — change First Check-in status from "Draft" to "Implemented"
  - Spec trace: Constitution Principle II

---

## Definition of Done

All of the following must be true before this submodule is considered complete:

### Code

- [ ] All tasks T-01 through T-22 are implemented
- [ ] Code compiles with zero errors and zero warnings
- [ ] No PII is collected or stored at any point during first check-in (AC-FC-02, BR-OKL-002)
- [ ] `onboarding_complete` flag is written ONLY by this submodule (Spec §4.3 step 5, §4.5)
- [ ] Write ordering enforced: server-first (Cloud Function), then local flag (SharedPreferences), then confirm (Plan §4.2)
- [ ] E-FC-002 recovery logic correctly sets flag for partial-persist crashes
- [ ] Cloud Function `recordCheckIn` persists timezone to `/users/{uid}.baseTimezone`

### Tests

- [ ] All Cloud Function tests pass (T-03)
- [ ] All client unit tests pass (T-07, T-10, T-12, T-19, T-22)
- [ ] All widget/integration tests pass (T-23 through T-28)
- [ ] Double-tap prevention verified in tests
- [ ] Back button blocking verified in tests

### Acceptance Criteria (from Spec §8)

- [ ] AC-FC-01: New user completes first check-in with a single, simple action
- [ ] AC-FC-02: No data input required beyond the check-in action itself
- [ ] AC-FC-03: Timezone anchored at first successful check-in
- [ ] AC-FC-04: No duplicate check-in on the same calendar day
- [ ] AC-FC-05: Clear, positive confirmation shown on success
- [ ] AC-FC-06: User transitioned to main experience after confirmation
- [ ] AC-FC-07: First check-in flow shown only once; returning users go to main experience
- [ ] AC-FC-08: `onboarding_complete` flag set to `true` after first check-in succeeds

### Analytics

- [ ] All 6 analytics events fire at the correct points in the flow (T-20, T-21, T-22)

### Documentation

- [ ] Spec updated if implementation diverged (T-29)
- [ ] Plan updated if implementation diverged (T-30)
- [ ] Module INDEX.md updated (T-31)

---

## Task Summary

| Group | Tasks | Count | Depends On |
|-------|-------|-------|------------|
| Prerequisites | P-01, P-02, P-03, P-04, P-05 | 5 | External |
| 1. Cloud Function Update | T-01, T-02, T-03 | 3 | P-05 |
| 2. First Check-in Screen | T-04, T-05, T-06, T-07 | 4 | P-01, P-02, P-03, P-04 |
| 3. Recording Service | T-08, T-09, T-10 | 3 | Groups 1–2 |
| 4. Recovery Logic | T-11, T-12 | 2 | Group 3 |
| 5. Confirmation & Transition | T-13, T-14, T-15 | 3 | Group 3 |
| 6. Error Handling | T-16, T-17, T-18, T-19 | 4 | Groups 2–5 |
| 7. Analytics | T-20, T-21, T-22 | 3 | Groups 2–5 |
| 8. Integration Tests | T-23, T-24, T-25, T-26, T-27, T-28 | 6 | Groups 1–7 |
| 9. Documentation | T-29, T-30, T-31 | 3 | Groups 1–8 |

**Total: 5 prerequisites + 31 tasks**

**Parallelism note:** Group 1 (Cloud Function) can be developed in parallel with Groups 2–5 (Flutter client). They converge at Group 3 (recording service calls the Cloud Function).

---

## Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-07 | Engineering Lead (via Speckit) | Initial task list generated from spec v1.2 (post-clarify) + plan v1.0 |
