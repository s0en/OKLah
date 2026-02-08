# Implementation Plan: First Check-in

**Module:** Onboarding
**Submodule:** First Check-in
**Spec Reference:** `docs/fsd/onboarding/first_checkin/spec.md` (v1.2, post-clarify)
**Version:** 1.0
**Status:** Draft
**Last Updated:** 2026-02-07
**Author:** Solution Architect (via Speckit)

---

## 1. Objective & Scope

### 1.1 Objective

Implement the first check-in flow so that a new user who has completed anonymous onboarding can perform a single-tap check-in, have their timezone anchored, and transition to the main app experience — completing the onboarding journey.

### 1.2 Scope (from Spec §1.2)

**Implementing:**

- Guided first check-in screen with single-tap CTA (Spec §4.2)
- Check-in recording: timestamp capture, timezone anchoring, durable persistence (Spec §4.3 steps 1–4)
- `onboarding_complete` flag write — sole writer (Spec §4.3 step 5, §4.5)
- Single check-in per calendar day enforcement for edge cases (Spec §3, BR-OKL-003)
- Success confirmation and transition to main experience (Spec §4.4)
- E-FC-002 recovery: detect existing check-in + set flag if missing (Spec §7)
- Analytics event emission (Spec §9)

**Not implementing (out of scope):**

- Anonymous session creation (owned by `onboarding/anonymous_onboarding`)
- Privacy disclosure (owned by `onboarding/anonymous_onboarding`)
- The 3-state routing gate itself (owned by `anonymous_onboarding`; this submodule is a *destination* of that gate)
- Subsequent daily check-ins (future PRD-002/003 scope)
- Streak tracking, achievements, engagement reinforcement
- Cross-device recovery

---

## 2. Assumptions & Dependencies

### 2.1 Assumptions

| # | Assumption | Rationale |
|---|-----------|-----------|
| A-01 | The `onboarding/anonymous_onboarding` submodule (or at minimum the 3-state routing gate) is implemented before or in parallel with this work. This submodule is a navigation target of that gate. | Spec §4.1 entry point; anonymous_onboarding plan IU-01. |
| A-02 | A valid Firebase Anonymous Auth session exists when the user reaches the first check-in screen. VR-FC-001 validates this. | Session creation is owned by anonymous_onboarding. |
| A-03 | The existing Cloud Function `recordCheckIn` in `services/firebase/functions/src/index.ts` is the intended server-side handler for check-ins. The first check-in calls this function. | Existing codebase already has this skeleton. |
| A-04 | The `onboarding_complete` flag is stored in local storage (`shared_preferences` or equivalent), consistent with how the routing gate reads it (anonymous_onboarding plan §4.2). | Cross-submodule contract: routing gate reads the flag; this submodule writes it. |
| A-05 | `forui` is used for UI components per PROJECT-CONFIG.md. | Tech stack mandate. |
| A-06 | The first check-in screen copy (welcoming guidance text, button label, confirmation message) will be provided by PO or UX writer. Implementation uses placeholder text. | Spec §4.2 defines behavioral rules but not exact wording. |
| A-07 | Timezone is captured as an IANA timezone identifier (e.g., `Asia/Kuala_Lumpur`), not just a UTC offset, to correctly handle DST transitions in future daily check-in logic. | BR-OKL-004 says "timezone offset/identifier"; IANA identifier is more robust. |

### 2.2 Dependencies

| # | Dependency | Type | Status | Impact if Missing |
|---|-----------|------|--------|-------------------|
| D-01 | Flutter app scaffold (entry point, routing, theme) | Prerequisite | Not started | Cannot build screens without app shell |
| D-02 | Firebase SDK integration (firebase_core, firebase_auth, cloud_firestore, cloud_functions) | Prerequisite | Not started | Cannot call `recordCheckIn` or read auth state |
| D-03 | Local storage solution (shared_preferences or flutter_secure_storage) | Prerequisite | Not started | Cannot persist `onboarding_complete` flag or read timezone |
| D-04 | `onboarding/anonymous_onboarding` — routing gate + session creation | Prerequisite | Not started | This screen is unreachable without the routing gate |
| D-05 | `recordCheckIn` Cloud Function operational | Co-requisite | Skeleton exists | Function exists but TODO items remain; first check-in needs it to persist check-ins server-side |
| D-06 | Analytics infrastructure (firebase_analytics) | Co-requisite | Not started | Events can be added after core flow works |
| D-07 | Main experience screen (or stub) | Downstream | Not started | Transition target after confirmation; can use a stub |

---

## 3. Non-Functional Requirements

| NFR | Target | Spec Trace | Notes |
|-----|--------|------------|-------|
| **Recording latency** | Check-in action → confirmation must feel instant. The Cloud Function call should complete within 2 seconds on a typical connection; UI should show a loading state if it takes longer. | §4.3, §4.4 | The `recordCheckIn` function does 2 Firestore writes; sub-second on typical network. |
| **Offline behavior** | The first check-in requires network connectivity to call the Cloud Function. If offline, display a clear error and allow retry (E-FC-004 analog). | §7 (E-FC-004) | Unlike the privacy disclosure (which renders offline), the check-in is a server write. |
| **Atomicity** | Steps 1–5 of §4.3 should be treated as a logical unit. If any step fails, no partial state should be confirmed to the user. E-FC-002 provides recovery for partial-persist crashes. | VR-FC-004 | See §4 Architecture for the write ordering strategy. |
| **Data minimization** | Only timestamp, timezone identifier, and UID are persisted. No PII. | BR-OKL-002 | Audit during code review. |
| **Accessibility** | First check-in screen must meet WCAG 2.1 AA: sufficient contrast, screen-reader labels, minimum tap target 48dp for the CTA. | General | Flutter/forui defaults help; verify during QA. |
| **Idempotency** | If the user taps the check-in button multiple times rapidly, only one check-in should be recorded. | §4.3, BR-OKL-003 | Disable the button after first tap; server-side enforcement via BR-OKL-003. |

---

## 4. High-Level Architecture Decisions

These decisions are constrained by the existing repo and PROJECT-CONFIG.md. No new architectural choices are introduced.

### 4.1 Check-in Persistence: Cloud Function `recordCheckIn`

The existing `recordCheckIn` Cloud Function (`services/firebase/functions/src/index.ts`) already implements the server-side write pattern:

1. Validates auth (`context.auth` required — satisfies VR-FC-001 server-side).
2. Creates an append-only document in `/checkins/{docId}` with `uid`, `ts`, and `source`.
3. Creates an event in `/events/{eventId}`.

**What needs to be added to the Cloud Function for first check-in:**

- Accept a `timezone` field from the client and persist it to `/users/{uid}` (one-time write for BR-OKL-004).
- The `source` field should distinguish first check-in: `source: "first_checkin"` vs future daily check-ins (`source: "tap"`).

**Client-side flow:**

```
User taps "I'm OK"
  → Disable button (prevent double-tap)
  → Show loading indicator
  → Call recordCheckIn({ timezone: "Asia/Kuala_Lumpur" })
  → On success:
    → Write onboarding_complete = true to local storage
    → Show confirmation
    → Navigate to main experience
  → On failure:
    → Re-enable button
    → Show error with retry
```

### 4.2 Write Ordering Strategy (VR-FC-004 + E-FC-002)

The spec requires both the check-in record and the `onboarding_complete` flag to be persisted before confirmation. The challenge is that the check-in is server-side (Firestore via Cloud Function) and the flag is client-side (local storage). A crash between the two creates a partial-persist state.

**Strategy: Server-first, then local flag, then confirm.**

1. Call `recordCheckIn` Cloud Function → server persists check-in + timezone.
2. On success response → write `onboarding_complete = true` to local storage.
3. On local write success → show confirmation → navigate.

**Crash recovery (E-FC-002):** If the app crashes between step 1 and step 2, on next launch:
- Routing gate sees "session exists + no flag" → routes to first check-in screen.
- First check-in screen loads → checks if a check-in already exists for today (query `/checkins` for current user + today's date).
- If exists → set flag locally (recovery) → show "already checked in" → transition to main.
- If not exists → show normal first check-in screen.

This E-FC-002 check requires a lightweight Firestore read on screen load. This is acceptable since it only fires in the edge case where the routing gate sends the user back to this screen.

### 4.3 Timezone Anchoring

- The client captures `DateTime.now().timeZoneName` (IANA identifier) at the moment the check-in button is tapped.
- This timezone is sent as a field in the `recordCheckIn` call.
- The Cloud Function persists it to `/users/{uid}.baseTimezone`.
- If the timezone cannot be determined (E-FC-003), the client sends `"UTC"` as fallback and logs an analytics event.

### 4.4 `onboarding_complete` Flag Contract

| Aspect | Detail |
|--------|--------|
| **Key** | `onboarding_complete` |
| **Storage** | Local storage (`SharedPreferences`) |
| **Type** | `bool` |
| **Writer** | This submodule only (Spec §4.3 step 5, §4.5) |
| **Reader** | Routing gate in `anonymous_onboarding` (Spec §4.1) |
| **Written when** | After `recordCheckIn` Cloud Function returns success |
| **Recovery writer** | E-FC-002 recovery path (check-in exists but flag missing) |

---

## 5. Data Handling Approach

### 5.1 Data Written by This Submodule

| Data | Storage | When Written | Purpose |
|------|---------|--------------|---------|
| Check-in record (`/checkins/{docId}`) | Cloud Firestore (via `recordCheckIn` function) | When user taps check-in CTA | Append-only check-in log (Spec §4.3 step 3) |
| Base timezone (`/users/{uid}.baseTimezone`) | Cloud Firestore (via `recordCheckIn` function) | First check-in only | Timezone anchor for calendar day boundaries (BR-OKL-004) |
| Event record (`/events/{eventId}`) | Cloud Firestore (via `recordCheckIn` function) | When user taps check-in CTA | Operational event log |
| `onboarding_complete` flag | Local storage (SharedPreferences) | After Cloud Function success response | Routing gate signal (Spec §4.3 step 5) |

### 5.2 Data Read by This Submodule

| Data | Storage | When Read | Purpose |
|------|---------|-----------|---------|
| Firebase Auth state (`currentUser`) | Firebase Auth SDK | Screen load (VR-FC-001) | Validate session exists |
| Existing check-in for today | Cloud Firestore (`/checkins` query) | Screen load (E-FC-002 recovery) | Detect partial-persist crash |
| Device timezone | Device OS API | Check-in tap moment | Timezone anchoring (BR-OKL-004) |

### 5.3 Data NOT Collected

Per BR-OKL-001 and BR-OKL-002:

- No name, email, phone, address
- No location data (timezone identifier only, not GPS)
- No behavioral tracking beyond defined analytics events

---

## 6. Implementation Units

### 6.1 Unit Breakdown

| # | Unit | Description | Spec Trace | Estimated Complexity |
|---|------|-------------|------------|----------------------|
| IU-01 | **First check-in screen** | Full-screen with welcoming guidance text, prominent "I'm OK" CTA button, loading state. Block back navigation (E-FC-005). | §4.2, AC-FC-01, AC-FC-02, E-FC-005 | Low–Medium |
| IU-02 | **Check-in recording service** | Client-side service that: (a) captures timestamp + timezone, (b) calls `recordCheckIn` Cloud Function, (c) writes `onboarding_complete` flag on success. Handles errors. | §4.3, VR-FC-001, VR-FC-004, AC-FC-08 | Medium |
| IU-03 | **Cloud Function update** | Update `recordCheckIn` to accept and persist `timezone` field to `/users/{uid}.baseTimezone`. Add `source: "first_checkin"` distinction. | BR-OKL-004, §4.3 step 2 | Low |
| IU-04 | **E-FC-002 recovery logic** | On screen load: query Firestore for existing check-in today. If found + flag missing → set flag → show "already checked in" → transition. | E-FC-002, VR-FC-002 | Medium |
| IU-05 | **Confirmation & transition** | Success confirmation screen/dialog with positive messaging. Transition to main experience (replacement navigation — no back). | §4.4, AC-FC-05, AC-FC-06 | Low |
| IU-06 | **Error handling** | Handle Cloud Function failures (network, server error), timezone detection failure (E-FC-003 UTC fallback), storage full (E-FC-004). | §7, E-FC-001 through E-FC-006 | Medium |
| IU-07 | **Analytics events** | Emit the 6 analytics events defined in Spec §9 at the appropriate points. | §9 | Low |

### 6.2 Suggested Implementation Order

```
IU-03 (Cloud Function update — can be done independently)
  ↕ (parallel with)
IU-01 (first check-in screen)
  → IU-02 (check-in recording service)
    → IU-05 (confirmation & transition)
      → IU-04 (E-FC-002 recovery logic)
        → IU-06 (error handling across all units)
          → IU-07 (analytics)
```

IU-03 (Cloud Function) can be developed in parallel with the Flutter client work. The happy path (IU-01 → IU-02 → IU-05) is built first, then recovery/error handling is layered on. Analytics is last.

---

## 7. Testing Approach

### 7.1 Unit Tests

| Test | Covers | IU |
|------|--------|----|
| No auth session → redirects to onboarding (VR-FC-001 enforcement) | Session validation | IU-02 |
| Check-in tap → calls `recordCheckIn` with correct timestamp + timezone | Recording flow | IU-02 |
| `recordCheckIn` success → `onboarding_complete` flag set to `true` | Flag write | IU-02 |
| `recordCheckIn` success → flag NOT set before function returns | Write ordering (VR-FC-004) | IU-02 |
| `recordCheckIn` failure → error shown, flag NOT set, no confirmation | Error path | IU-02, IU-06 |
| Double-tap prevention → button disabled after first tap | Idempotency | IU-01 |
| Timezone captured as IANA identifier at tap moment | Timezone anchoring | IU-02 |
| Timezone unavailable → UTC fallback used + analytics event logged | E-FC-003 | IU-02, IU-06 |
| E-FC-002 recovery: existing check-in found + no flag → flag set + "already checked in" shown | Partial-persist recovery | IU-04 |
| E-FC-002 recovery: no existing check-in found → normal screen shown | Non-recovery path | IU-04 |
| Midnight boundary: tap at 23:59:59 → check-in belongs to current day | E-FC-006 | IU-02 |
| Cloud Function: `recordCheckIn` with timezone → persists to `/users/{uid}.baseTimezone` | Server-side timezone write | IU-03 |
| Cloud Function: `recordCheckIn` without auth → rejects | Server auth validation | IU-03 |

### 7.2 Widget / Integration Tests

| Test | Covers |
|------|--------|
| Happy path: screen shown → tap CTA → loading → confirmation → navigates to main experience | AC-FC-01, AC-FC-05, AC-FC-06 |
| Back button / swipe-back does NOT navigate away from first check-in screen | E-FC-005 |
| Recording failure → error message shown → retry → success → confirmation | E-FC-004, retry flow |
| E-FC-002 recovery flow: screen opens with existing check-in → "already checked in" → main experience | E-FC-002 end-to-end |
| All 6 analytics events fire at correct points in the flow | §9 events |
| Full cross-submodule flow: anonymous onboarding → first check-in → confirmation → main experience | End-to-end (with anonymous_onboarding) |

### 7.3 Manual / QA Tests

| Test | Covers |
|------|--------|
| First check-in screen copy review: welcoming, clear, non-punitive | US-FC-003, BR-OKL-006 spirit |
| Accessibility audit: screen reader, contrast, tap targets (48dp minimum) | NFR |
| Fresh install on physical device: full onboarding → first check-in flow | Real-device validation |
| Force-close during check-in recording → re-launch → correct recovery path | E-FC-001 |
| Airplane mode during check-in → error shown → re-enable network → retry succeeds | E-FC-004 analog |
| Check timezone persisted correctly in Firestore after first check-in | BR-OKL-004 verification |

### 7.4 Test Infrastructure Notes

- **Firebase Auth mocking:** Use `firebase_auth_mocks` package or custom mock for `FirebaseAuth` in unit tests.
- **Cloud Functions mocking:** Mock the `HttpsCallable` interface for `recordCheckIn` in client-side unit tests.
- **Cloud Functions testing:** Use Firebase Emulator Suite for integration tests against the actual `recordCheckIn` function.
- **Local storage mocking:** Use `shared_preferences` test helpers (`SharedPreferences.setMockInitialValues`).
- **Firestore mocking:** Use `fake_cloud_firestore` package for the E-FC-002 recovery query in unit tests.
- **Widget tests:** Use Flutter's `WidgetTester` for screen-level tests.

---

## 8. Rollout Notes

### 8.1 Dev / Test Readiness

| Milestone | Criteria |
|-----------|----------|
| **Dev complete** | All 7 implementation units done. Unit tests pass. Widget tests pass against mocks. E-FC-002 recovery logic verified. `onboarding_complete` flag correctly written. |
| **Test ready** | Integration tests pass against Firebase Emulator (Cloud Function + Firestore). First check-in screen content reviewed by PO. Accessibility baseline checked. Cross-submodule flow tested with anonymous_onboarding. |

### 8.2 Beta Readiness

| Criteria | Details |
|----------|---------|
| `recordCheckIn` Cloud Function deployed to Firebase project `oklah-mvp` | Required for real-device testing |
| Firestore security rules deployed (current rules already support `/checkins` and `/users/{uid}`) | Already in repo; verify deployed |
| `onboarding/anonymous_onboarding` submodule implemented | Upstream prerequisite for the full flow |
| First check-in screen copy finalized by PO | Placeholder text replaced with approved copy |
| Analytics events verified in Firebase Analytics dashboard / DebugView | Confirm events fire correctly on real device |
| Timezone anchoring verified: correct IANA identifier persisted in `/users/{uid}.baseTimezone` | Spot-check in Firestore console |
| No PII audit passed | Confirm no unexpected data collected during first check-in |

### 8.3 Risks at Rollout

| Risk | Mitigation |
|------|------------|
| `recordCheckIn` Cloud Function cold start adds latency to first check-in | Cold start is typically 1–3s for Node.js functions. Show loading indicator. Consider Firebase Functions min instances if latency is unacceptable. |
| E-FC-002 recovery query adds a Firestore read on every screen load | Only fires when routing gate sends user to this screen (session exists + no flag). For returning users with flag `true`, they never hit this screen. Acceptable trade-off. |
| Timezone identifier format varies across devices/OS versions | Use Dart's `DateTime.now().timeZoneName` which returns IANA on most platforms. Add a validation check; fall back to UTC if format is unexpected (E-FC-003). |
| User force-closes during Cloud Function call (E-FC-001) | E-FC-002 recovery handles this: on next launch, detects existing check-in server-side → sets flag locally → transitions to main. |

---

## 9. Traceability Matrix

| Spec Section | Implementation Unit | Test Coverage |
|-------------|---------------------|---------------|
| §1 Overview | — (context only) | — |
| §2 User Stories (US-FC-001, 002, 003) | IU-01, IU-02, IU-05 | Unit + Widget |
| §3 Business Rules (BR-OKL-003, 004) | IU-02, IU-03 | Unit + Widget |
| §4.1 Entry Point | — (owned by anonymous_onboarding routing gate) | Cross-submodule widget test |
| §4.2 First Check-in Action | IU-01 | Unit + Widget |
| §4.3 Recording (steps 1–5) | IU-02, IU-03 | Unit + Integration |
| §4.4 Confirmation & Transition | IU-05 | Widget |
| §4.5 Post-First-Check-in Behavior (flag ownership) | IU-02 | Unit (flag write verified) |
| §5 State Transitions | IU-01, IU-02, IU-04, IU-05 | Widget (full flow) |
| §6 Validation Rules (VR-FC-001–004) | IU-01, IU-02, IU-04 | Unit |
| §7 Error & Edge Cases (E-FC-001–006) | IU-04, IU-06 | Unit + Widget + Manual |
| §8 Acceptance Criteria (AC-FC-01–08) | All IUs | Widget + Manual |
| §9 Analytics | IU-07 | Unit + Manual |

---

## 10. Open Items

| # | Item | Owner | Status |
|---|------|-------|--------|
| OI-01 | Flutter app scaffold must be created before this plan can execute. | Engineering Lead | Blocked (shared with anonymous_onboarding OI-01) |
| OI-02 | Firebase project setup and SDK integration. | Engineering Lead | Blocked (shared with anonymous_onboarding OI-02) |
| OI-03 | First check-in screen copy (guidance text, button label, confirmation message). | PO | Pending |
| OI-04 | Confirm `recordCheckIn` Cloud Function should be extended (timezone field + source distinction) vs. creating a separate `recordFirstCheckIn` function. | Solution Architect | Open — Recommendation: extend existing function (simpler, single check-in path). |
| OI-05 | Confirm whether `/users/{uid}` document is created at anonymous onboarding (anonymous_onboarding plan OI-04) or first check-in. Affects where `baseTimezone` is written. | Solution Architect | Open — depends on anonymous_onboarding OI-04 resolution. If created at onboarding, first check-in updates it. If not, first check-in creates it. Either way works; Firestore `set` with `merge: true` handles both. |
| OI-06 | Main experience screen (or stub) must exist as a navigation target after confirmation. | Engineering Lead | Not started |

---

## 11. Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-07 | Solution Architect (via Speckit) | Initial plan generated from first_checkin spec v1.2 (post-clarify). Key decisions: (1) Check-in persisted via existing `recordCheckIn` Cloud Function; (2) Server-first write ordering with E-FC-002 local recovery; (3) Timezone as IANA identifier; (4) `onboarding_complete` flag in SharedPreferences; (5) 7 implementation units identified. |
