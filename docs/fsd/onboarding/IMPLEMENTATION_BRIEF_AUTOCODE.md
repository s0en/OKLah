# Implementation Brief (Autocode) — Anonymous Onboarding + First Check-in

**Task files:** `anonymous_onboarding/tasks.md` + `first_checkin/tasks.md`  
**Mode:** `--autocode` (scaffolding, boilerplate, minimal wiring, test stubs)

---

## Intended Behavior (5–10 bullets from specs)

- **Anonymous onboarding:** 3-state routing gate at launch (privacyDisclosure / firstCheckin / mainExperience) based on Firebase Auth + `onboarding_complete` flag; privacy disclosure with 3 content points and explicit "Continue"; anonymous session creation only after acknowledgement; no PII; transition to first check-in after session creation.
- **First check-in:** Guided screen with single "I'm OK" CTA; record check-in via Cloud Function with `timezone` and `source: "first_checkin"`; one-time write of `baseTimezone` to `/users/{uid}`; sole writer of `onboarding_complete` after successful recording; confirmation and transition to main experience; E-FC-002 recovery when check-in exists but flag missing.
- **Cloud Function:** `recordCheckIn` accepts optional `timezone` (persisted to `/users/{uid}.baseTimezone` once) and `source` (default `"tap"`); does not overwrite existing `baseTimezone`.
- **Flutter:** Routing gate, disclosure screen, anonymous auth service, analytics stubs; first check-in screen, check-in recording service, first check-in analytics; stub screens for first check-in and main experience until full flows exist.

---

## Patch Bundle (Autocode)

### Anonymous Onboarding

| FILE | CHANGE | CODE |
|-----|--------|------|
| `apps/mobile/pubspec.yaml` | New Flutter app with firebase_core, firebase_auth, shared_preferences, firebase_analytics, cloud_firestore, cloud_functions | Created |
| `apps/mobile/lib/main.dart` | Entry point: Firebase.initializeApp() then runApp(OKLahApp()) | Created |
| `apps/mobile/lib/app.dart` | Root app + _OnboardingGate (FutureBuilder on OnboardingRouter.resolveDestination); disclosure Continue → AnonymousAuthService.createAnonymousSession → setState to FirstCheckinStubScreen; loading + error + Try Again | Created |
| `apps/mobile/lib/features/onboarding/services/onboarding_router.dart` | 3-state gate: Firebase Auth + SharedPreferences onboarding_complete; returns privacyDisclosure / firstCheckin / mainExperience; edge case flag true but no session → privacyDisclosure | Created |
| `apps/mobile/lib/features/onboarding/screens/privacy_disclosure_screen.dart` | Full-screen: 3 content points, Continue CTA, PopScope canPop: false; loading, error, Try Again | Created |
| `apps/mobile/lib/features/onboarding/services/anonymous_auth_service.dart` | createAnonymousSession() → signInAnonymously(); does NOT set onboarding_complete | Created |
| `apps/mobile/lib/features/onboarding/services/onboarding_analytics.dart` | 5 methods: logOnboardingStarted, logPrivacyDisclosureShown, logPrivacyDisclosureAcknowledged, logAnonymousSessionCreated, logOnboardingCompleted | Created |
| `apps/mobile/lib/features/onboarding/screens/first_checkin_stub_screen.dart` | Placeholder "First check-in — coming soon" | Created |
| `apps/mobile/test/features/onboarding/services/onboarding_router_test.dart` | 4 test stubs (no session+no flag, session+flag true, session+flag false, flag true+no session) | Created |
| `apps/mobile/test/features/onboarding/screens/privacy_disclosure_screen_test.dart` | Widget tests: 3 content points, Continue callback, PopScope canPop false | Created |
| `apps/mobile/test/features/onboarding/services/anonymous_auth_service_test.dart` | Unit test stubs: success returns User; failure throws | Created |
| `apps/mobile/test/features/onboarding/services/onboarding_analytics_test.dart` | Unit test stub: each method logs correct event name | Created |

### First Check-in

| FILE | CHANGE | CODE |
|-----|--------|------|
| `services/firebase/functions/src/index.ts` | recordCheckIn: accept optional `timezone` and `source`; persist timezone to `/users/{uid}.baseTimezone` only if not already set; write `source` to check-in doc (default "tap") | **Patched** |
| `services/firebase/functions/src/__tests__/recordCheckIn.test.ts` | Unit test file: 6 scenarios (timezone persist, no timezone, source first_checkin, default tap, no auth, existing baseTimezone) — stubs with TODO for mocks | Created |
| `apps/mobile/lib/features/onboarding/screens/first_checkin_screen.dart` | Full-screen: guidance text, "I'm OK" CTA, PopScope canPop: false; loading, error | Created |
| `apps/mobile/lib/features/onboarding/services/checkin_recording_service.dart` | recordFirstCheckin(): validate auth, capture timezone (DateTime.now().timeZoneName, fallback UTC), call recordCheckIn with timezone + source "first_checkin"; on success set onboarding_complete true in SharedPreferences | Created |
| `apps/mobile/lib/features/onboarding/services/first_checkin_analytics.dart` | 6 methods: logFirstCheckinScreenShown, logFirstCheckinAttempted, logFirstCheckinCompleted, logFirstCheckinFailed, logFirstCheckinTimeElapsed(Duration), logTimezoneAnchored(String, isFallback) | Created |
| `apps/mobile/lib/features/main/screens/main_experience_stub_screen.dart` | Placeholder "Welcome to OKLah — coming soon" | Created |
| `apps/mobile/test/features/onboarding/screens/first_checkin_screen_test.dart` | Widget tests: guidance + CTA, callback on tap, PopScope | Created |
| `apps/mobile/test/features/onboarding/services/checkin_recording_service_test.dart` | Unit test stubs: no auth throws; auth calls recordCheckIn; success sets flag; failure does not set flag | Created |

---

## Cursor-required (not safe to autocode)

- **P-01–P-03 (both modules):** Flutter app scaffold: ensure `flutter create` or equivalent has been run so `apps/mobile` is a valid Flutter project (analysis_options, android/, ios/ if needed). Current scaffold is file-only; add platform folders and `flutter pub get` as needed.
- **T-02 anonymous:** Wire `logOnboardingStarted` when gate selects privacyDisclosure; `logPrivacyDisclosureShown` when disclosure screen is displayed (e.g. initState or first frame).
- **T-09 anonymous (optional):** Firestore user document on session creation — only if Plan OI-04 decision is to implement; otherwise skip.
- **T-11 first_checkin:** E-FC-002 recovery: on first check-in screen load, query Firestore for today’s check-in; if exists and flag false/missing, set flag and show "already checked in" then navigate to main experience. Logic in screen or dedicated service.
- **T-12 first_checkin:** Wire app to use `FirstCheckinScreen` (and recording + analytics) when gate returns firstCheckin; replace FirstCheckinStubScreen with real flow.
- **T-13–T-14 first_checkin:** Confirmation view after successful recording; then replacement navigation to main experience (or MainExperienceStubScreen).
- **T-16 first_checkin:** Cloud Function failure handling: show error, re-enable CTA, "Try Again" re-invokes recording.
- **T-18 first_checkin:** Timestamp at tap moment for midnight boundary (E-FC-006) — ensure client sends timestamp if required by backend or spec.
- **T-19–T-22 first_checkin:** Wire all 6 first check-in analytics at the correct points; unit test each method with mocked FirebaseAnalytics.
- **Firebase Functions tests:** Implement 6 recordCheckIn tests with `firebase-functions-test` (or emulator); add Jest (or Mocha) and test script to `package.json`.
- **Flutter unit/widget tests:** Replace placeholders with real mocks (FirebaseAuth, SharedPreferences, Cloud Functions, FirebaseAnalytics) and assertions.
- **Integration / widget tests:** T-21–T-25 (anonymous), T-23–T-28 (first_checkin): full happy path, re-launch scenarios, force-close, error retry, E-FC-002 recovery, cross-submodule flow — implement with mocked backend and routing.
- **Documentation sync:** T-26–T-28 (anonymous), T-29–T-31 (first_checkin): update spec/plan/INDEX.md if implementation diverges; increment versions.

---

## What Remains for Cursor

1. **Prerequisites:** Confirm/complete Flutter app creation (P-01), Firebase SDK (P-02), local storage (P-03); add `firebase-functions-test` and Jest (or Mocha) for Cloud Function tests.
2. **Analytics wiring:** Anonymous: logOnboardingStarted + logPrivacyDisclosureShown at gate/disclosure; First check-in: all 6 events at the specified points.
3. **First check-in flow in app:** Use `FirstCheckinScreen` + `CheckinRecordingService` when gate returns firstCheckin; confirmation UI and replacement navigation to main experience; error handling and "Try Again."
4. **E-FC-002 recovery:** On first check-in screen load, check for existing check-in today; if found and flag missing, set flag and transition to main with "already checked in" message.
5. **Tests:** Implement mocks and full assertions for all unit/widget/integration test files; run Cloud Function tests with emulator or firebase-functions-test.
6. **Optional:** Firestore user document on anonymous session (T-09) if OI-04 decision is yes; timestamp at tap for E-FC-006 if required.
7. **Docs:** Update spec/plan/INDEX.md after implementation; increment versions per Constitution.
