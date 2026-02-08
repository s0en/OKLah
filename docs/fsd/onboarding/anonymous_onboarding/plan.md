# Implementation Plan: Anonymous Onboarding

**Module:** Onboarding
**Submodule:** Anonymous Onboarding
**Spec Reference:** `docs/fsd/onboarding/anonymous_onboarding/spec.md` (v1.0, post-clarify)
**Version:** 2.0
**Status:** Draft
**Last Updated:** 2026-02-07
**Author:** Solution Architect (via Speckit)

---

## 1. Objective & Scope

### 1.1 Objective

Implement the anonymous onboarding flow so that a new user can launch OKLah, receive a privacy disclosure, acknowledge it, and have an anonymous session created — all without any form of registration or identity.

### 1.2 Scope (from Spec §1.2)

**Implementing:**

- 3-state app launch routing gate (Spec §4.1)
- Privacy transparency disclosure with blocking acknowledgement (Spec §4.2)
- Anonymous session creation via Firebase Anonymous Auth (Spec §4.3)
- Transition/handoff to the first check-in flow (Spec §4.4)
- Analytics event emission (Spec §9)

**Not implementing (out of scope):**

- Account registration or identity verification
- Cross-device recovery
- The check-in action itself (separate submodule: `onboarding/first_checkin`)
- Setting the onboarding-complete flag (owned by `onboarding/first_checkin` per Spec §4.4)
- Any backend Cloud Functions (onboarding is entirely client-side + Firebase Auth)

---

## 2. Assumptions & Dependencies

### 2.1 Assumptions

| # | Assumption | Rationale |
|---|-----------|-----------|
| A-01 | The Flutter app shell (entry point, routing, theme) will be created before or in parallel with this work. This plan assumes a runnable Flutter app exists. | The `apps/` directory is currently empty; app scaffolding is a prerequisite. |
| A-02 | Firebase project `oklah-mvp` is provisioned and Firebase Anonymous Auth is enabled. | PROJECT-CONFIG.md specifies Firebase Auth: Anonymous sign-in. |
| A-03 | `forui` is used for UI components per PROJECT-CONFIG.md. | Tech stack mandate. |
| A-04 | No backend Cloud Function is needed for anonymous onboarding. Firebase Anonymous Auth is invoked directly from the client SDK. | Firestore rules already support anonymous auth (`isSignedIn()` checks `request.auth != null`). |
| A-05 | The privacy disclosure content (copy) will be provided by the PO or UX writer. Implementation uses placeholder text until final copy is delivered. | Spec §4.2 defines the 3 content requirements but not exact wording. |

### 2.2 Dependencies

| # | Dependency | Type | Status | Impact if Missing |
|---|-----------|------|--------|-------------------|
| D-01 | Flutter app scaffold (entry point, routing framework, theme) | Prerequisite | Not started | Cannot build screens without app shell |
| D-02 | Firebase SDK integration (firebase_core, firebase_auth) | Prerequisite | Not started | Cannot create anonymous sessions |
| D-03 | Local storage solution (shared_preferences or flutter_secure_storage) | Prerequisite | Not started | Cannot persist flags or read routing state |
| D-04 | `onboarding/first_checkin` implementation | Downstream | Not started | Handoff target; this module can stub the transition |
| D-05 | Analytics infrastructure (firebase_analytics) | Co-requisite | Not started | Events can be added after core flow works |

---

## 3. Non-Functional Requirements

| NFR | Target | Spec Trace | Notes |
|-----|--------|------------|-------|
| **Startup latency** | 3-state routing gate must not add perceptible delay to app launch. | §4.1 | Reading a boolean + checking Firebase Auth state are both sub-50ms operations. |
| **Offline resilience** | Privacy disclosure must render without network. Session creation requires network (Firebase Auth). If offline, the user should see the disclosure but session creation should fail gracefully with a retry option. | §7 (E-AO-003) | Firebase Anonymous Auth requires connectivity. |
| **Data minimization** | Only the Firebase anonymous UID is persisted locally by this submodule. The onboarding-complete flag is NOT written by this submodule (Spec §4.4). | BR-OKL-002 | Audit during code review. |
| **Accessibility** | Privacy disclosure screen must meet WCAG 2.1 AA: sufficient contrast, screen-reader labels, minimum tap target 48dp. | General | Flutter/forui defaults help; verify during QA. |
| **Idempotency** | Repeated app launches before acknowledgement must safely re-show the disclosure without side effects. | §4.2, E-AO-001 | No state is written until session creation succeeds. |

---

## 4. High-Level Architecture Decisions

These decisions are constrained by the existing repo and PROJECT-CONFIG.md. No new architectural choices are introduced.

### 4.1 Authentication: Firebase Anonymous Auth

Per PROJECT-CONFIG.md, the app uses **Firebase Auth: Anonymous sign-in**. This maps directly to Spec §4.3 (anonymous session creation).

- The Flutter client calls `FirebaseAuth.instance.signInAnonymously()` after the user acknowledges the privacy disclosure.
- The resulting `User.uid` becomes the anonymous session identifier.
- No PII is collected (BR-OKL-001). Firebase Anonymous Auth assigns a random UID with no associated email, phone, or name.

### 4.2 3-State Routing Gate

The spec (§4.1) defines a 3-state routing model. The routing gate checks two signals:

1. **Firebase Auth state** — Does a valid anonymous session exist?
2. **Completion flag** — Has the first check-in been recorded? (Flag is written by `first_checkin` submodule, not by this submodule.)

```
App start
  → Check Firebase Auth state
    → No session: route to PrivacyDisclosureScreen (first time)
    → Session exists: check completion flag
      → Flag true: route to MainExperience
      → Flag false/missing: route to FirstCheckinScreen (session exists, no check-in yet)
  → Edge case: flag is true but no Firebase Auth session
    → Treat as first time; route to PrivacyDisclosureScreen (recovery for E-AO-002/E-AO-004)
```

**Key invariant (Spec §4.1):** The user has completed onboarding if and only if both (1) a local completion flag is `true` AND (2) a valid anonymous session exists. If either is missing, re-enter onboarding.

**Completion flag ownership (Spec §4.4):** This submodule does NOT write the completion flag. The `onboarding/first_checkin` submodule sets it after the first check-in is successfully recorded. This means:

- After anonymous session creation, the user has a session but no completion flag.
- On next launch (if the user closed the app before checking in), the routing gate sees "session exists + no flag" → routes to first check-in, NOT back to the privacy disclosure.

### 4.3 Privacy Disclosure: Client-Side Only

- The privacy disclosure is a static screen rendered entirely on-device.
- No network call is needed to display it.
- The acknowledgement action (button tap) is a local UI event that gates the next step.

---

## 5. Data Handling Approach

### 5.1 Data Written by This Submodule

| Data | Storage | When Written | Purpose |
|------|---------|--------------|---------|
| Anonymous UID | Firebase Auth (managed by Firebase SDK) | `signInAnonymously()` call | Anonymous session identity (§4.3) |
| `/users/{uid}` document (optional) | Cloud Firestore | After anonymous auth succeeds | Downstream submodules may need a user doc; creating it at onboarding avoids race conditions later |

### 5.2 Data NOT Written by This Submodule

| Data | Owner | When Written | Notes |
|------|-------|--------------|-------|
| `onboarding_complete` (bool) | `onboarding/first_checkin` | After first check-in succeeds | Per Spec §4.4: this submodule does NOT set the completion flag |

### 5.3 Data NOT Collected

Per BR-OKL-001 and BR-OKL-002, the following are explicitly excluded:

- Name, email, phone number, address
- Device identifiers beyond what Firebase Auth assigns
- Location data
- Behavioral tracking beyond the defined analytics events

---

## 6. Implementation Units

### 6.1 Unit Breakdown

| # | Unit | Description | Spec Trace | Estimated Complexity |
|---|------|-------------|------------|----------------------|
| IU-01 | **3-state routing gate** | At app launch: check Firebase Auth state + completion flag. Route to one of 3 destinations: privacy disclosure, first check-in, or main experience. Include edge-case recovery (flag/session mismatch). | §4.1, §5, VR-AO-002, E-AO-004 | Medium |
| IU-02 | **Privacy disclosure screen** | Full-screen, blocking disclosure with 3 content points and a single "Continue" CTA. System back / swipe-back does NOT dismiss. | §4.2, VR-AO-001, AC-AO-02, AC-AO-03 | Low |
| IU-03 | **Anonymous session creation** | Call `signInAnonymously()`, handle success/failure. On success, proceed to handoff. Do NOT set completion flag. Optionally create `/users/{uid}` Firestore document. | §4.3, §4.4, AC-AO-04, E-AO-002, E-AO-003 | Low–Medium |
| IU-04 | **Transition to first check-in** | Navigate to the first check-in screen (or a stub/placeholder if `first_checkin` is not yet implemented). | §4.4 | Low |
| IU-05 | **Analytics events** | Emit the 5 analytics events defined in Spec §9 at the appropriate points in the flow. | §9 | Low |
| IU-06 | **Error handling** | Handle network errors during `signInAnonymously()`, storage errors, and edge cases E-AO-001 through E-AO-004. | §7 | Medium |

### 6.2 Suggested Implementation Order

```
IU-01 (3-state routing gate)
  → IU-02 (disclosure screen)
    → IU-03 (session creation — NO flag write)
      → IU-04 (transition to first check-in)
        → IU-06 (error handling across all units)
          → IU-05 (analytics)
```

This follows the user flow sequentially. Error handling is layered on after the happy path works. Analytics is last because it's non-blocking.

---

## 7. Testing Approach

### 7.1 Unit Tests

| Test | Covers | IU |
|------|--------|----|
| No session + no flag → routes to privacy disclosure | First-time detection (3-state gate) | IU-01 |
| Session exists + flag `true` → routes to main experience | Returning user bypass | IU-01 |
| Session exists + flag `false`/missing → routes to first check-in | Session-but-no-checkin path | IU-01 |
| Flag `true` but no Firebase Auth session → routes to privacy disclosure (recovery) | Edge case E-AO-002 / E-AO-004 | IU-01 |
| Privacy disclosure: "Continue" button fires acknowledgement callback | Explicit acknowledgement | IU-02 |
| Privacy disclosure: back button / system back does NOT navigate away | Passive dismissal blocked (VR-AO-001) | IU-02 |
| Session creation: `signInAnonymously()` success → navigates to first check-in, flag is NOT set | Session created, no flag write | IU-03 |
| Session creation: `signInAnonymously()` failure → error shown, no navigation | Error path | IU-03, IU-06 |
| Analytics: correct events fired at each step | Event emission | IU-05 |

### 7.2 Widget / Integration Tests

| Test | Covers |
|------|--------|
| Full onboarding flow: launch → disclosure → acknowledge → session created → navigates to first check-in screen | End-to-end happy path (AC-AO-01 through AC-AO-04) |
| Re-launch after session created but no check-in: skips disclosure, shows first check-in screen | AC-AO-05 (session-but-no-checkin path) |
| Re-launch after onboarding + check-in complete: skips disclosure + check-in, goes to main experience | AC-AO-05 (full completion path) |
| Force-close during disclosure → re-launch shows disclosure again | E-AO-001 |
| Force-close after acknowledgement but before session completes → re-launch shows disclosure again | E-AO-002 |
| Network unavailable during session creation → error displayed, retry works | E-AO-003 analog |

### 7.3 Manual / QA Tests

| Test | Covers |
|------|--------|
| Privacy disclosure content review: all 3 points present and clearly communicated | AC-AO-02 (content quality) |
| Accessibility audit: screen reader, contrast, tap targets | NFR |
| Fresh install on physical device: full flow end-to-end | Real-device validation |
| App data cleared after onboarding → re-launch triggers full onboarding | Invariant from §4.1 |

### 7.4 Test Infrastructure Notes

- **Firebase Auth mocking:** Use `firebase_auth_mocks` package or a custom mock for `FirebaseAuth` to unit-test without hitting Firebase.
- **Local storage mocking:** Use `shared_preferences` test helpers (`SharedPreferences.setMockInitialValues`).
- **Widget tests:** Use Flutter's `WidgetTester` for screen-level tests.
- **Integration tests:** Use Firebase Emulator Suite for tests that hit Firestore.

---

## 8. Rollout Notes

### 8.1 Dev / Test Readiness

| Milestone | Criteria |
|-----------|----------|
| **Dev complete** | All 6 implementation units done. Unit tests pass. Widget tests pass against mocks. 3-state routing gate correctly handles all 4 launch scenarios. |
| **Test ready** | Integration tests pass against Firebase Emulator. Privacy disclosure content reviewed by PO. Accessibility baseline checked. |

### 8.2 Beta Readiness

| Criteria | Details |
|----------|---------|
| Firebase project (`oklah-mvp`) provisioned with Anonymous Auth enabled | Required for real-device testing |
| Privacy disclosure copy finalized by PO | Placeholder text replaced with approved copy |
| `onboarding/first_checkin` submodule implemented (or a meaningful stub exists) | Handoff target must exist for the flow to complete |
| Analytics events verified in Firebase Analytics dashboard / DebugView | Confirm events fire correctly on real device |
| No PII audit passed | Confirm no unexpected data is collected during onboarding |

### 8.3 Risks at Rollout

| Risk | Mitigation |
|------|------------|
| Firebase Anonymous Auth rate limiting on high-traffic launch | Firebase free tier allows 10K anonymous auths/month; monitor usage. Upgrade plan if needed. |
| User closes app during `signInAnonymously()` network call (E-AO-002) | Routing gate handles this: on next launch, detects no auth session → re-enters onboarding from disclosure. |
| Privacy disclosure copy not finalized before dev complete | Use placeholder text; swap in final copy via a single string file update. No code change needed. |

---

## 9. Traceability Matrix

| Spec Section | Implementation Unit | Test Coverage |
|-------------|---------------------|---------------|
| §1 Overview | — (context only) | — |
| §2 User Stories (US-AO-001, US-AO-002) | IU-01, IU-02, IU-03, IU-04 | Unit + Widget |
| §3 Business Rules (BR-OKL-001, 002, 007) | IU-02, IU-03 | Unit + Widget |
| §4.1 First-Time Detection (3-state) | IU-01 | Unit (4 scenarios) |
| §4.2 Privacy Disclosure | IU-02 | Unit + Widget + Manual |
| §4.3 Anonymous Session Creation | IU-03 | Unit + Integration |
| §4.4 Transition to First Check-in (no flag write) | IU-03, IU-04 | Unit + Widget |
| §5 State Transitions (incl. cross-submodule note) | IU-01, IU-02, IU-03, IU-04 | Widget (full flow) |
| §6 Validation Rules (VR-AO-001–003) | IU-01, IU-02, IU-03 | Unit |
| §7 Error & Edge Cases (E-AO-001–004) | IU-06 | Unit + Widget |
| §8 Acceptance Criteria (AC-AO-01–06) | All IUs | Widget + Manual |
| §9 Analytics | IU-05 | Unit + Manual |

---

## 10. Open Items

| # | Item | Owner | Status |
|---|------|-------|--------|
| OI-01 | Flutter app scaffold must be created before this plan can execute. | Engineering Lead | Blocked |
| OI-02 | Firebase project setup and SDK integration. | Engineering Lead | Blocked |
| OI-03 | Privacy disclosure final copy. | PO | Pending |
| OI-04 | Confirm whether a `/users/{uid}` Firestore document should be created at onboarding or deferred to first check-in. | Solution Architect | Open |
| OI-05 | PO decision on privacy disclosure format (single screen vs. multi-step) — from clarify run, not yet resolved. | PO | Pending |

---

## 11. Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-06 | Solution Architect (via Speckit) | Initial plan generated from anonymous_onboarding spec v1.0 |
| 2.0 | 2026-02-07 | Solution Architect (via Speckit) | Re-synced with post-clarify spec. Key changes: (1) 3-state routing gate replaces 2-state model; (2) Completion flag ownership corrected — this submodule does NOT write the flag; (3) Data handling §5 split into "written by this submodule" vs "NOT written"; (4) Unit tests updated for 3-state gate (4 scenarios); (5) Widget tests updated for session-but-no-checkin path; (6) Added OI-05 for PO disclosure format decision. |
