# Quick Start (Option B — Firebase backendless)

## 1) Prereqs
- Flutter SDK + Xcode / Android Studio
- Node.js 18+ (for Firebase Functions)
- Firebase CLI: `npm i -g firebase-tools`

## 2) Create Firebase project
1. Create a Firebase project in Firebase Console
2. Enable:
   - Authentication -> **Anonymous**
   - Cloud Firestore
   - Cloud Functions
   - Cloud Messaging (FCM)
   - Analytics (optional but recommended)
3. (Recommended) Enable BigQuery export for Analytics

## 3) Local dev with Emulator Suite
From `services/firebase`:

```bash
cd services/firebase
npm i
firebase login
firebase init emulators   # if you want to re-init; this repo includes defaults
firebase emulators:start
```

## 4) Flutter app wiring (placeholder)
In `apps/mobile`:
- Add firebase_core, firebase_auth, cloud_firestore, firebase_messaging packages
- Implement:
  - Anonymous sign-in at first launch
  - 1-tap daily check-in
  - listen for “nudge required” flags and show in-app banner/chat

## 5) Deploy (when ready)
```bash
cd services/firebase
firebase deploy
```

## 6) Reporting
- Use BigQuery + Looker Studio dashboard (recommended)
- Or query Firestore exports / logs for operational reports

Next: read `docs/functional/01-anonymous-onboarding.md` and `docs/functional/03-thresholds-nudges-escalation.md`.

