# Deploying the Flutter application — Guide (current stage)

This guide explains how to **build and deploy** the OKLah Flutter app at its current stage (onboarding scaffold, anonymous auth, first check-in flow). It assumes you have completed the [Flutter prerequisites](FLUTTER_PREREQUISITES.md) (P-01, P-02, P-03).

**References:** `PROJECT-CONFIG.md`, `docs/fsd/onboarding/IMPLEMENTATION_BRIEF_AUTOCODE.md`

---

## Current stage

- **App:** `apps/mobile/` — Flutter app with 3-state onboarding gate, privacy disclosure, anonymous session creation, first check-in stub (or full flow when implemented).
- **Backend:** Firebase project **oklah-mvp** (Auth, Firestore, Cloud Functions for `recordCheckIn`).
- **Deploy target:** Per PROJECT-CONFIG, MVP uses **Firebase CLI**; **GitHub Actions** is optional later. No K8s for the app.

---

## Before you deploy

1. **Flutter project is complete** — You have run `flutter create .` in `apps/mobile/` (or equivalent) so `android/` and `ios/` exist. See [FLUTTER_PREREQUISITES.md](FLUTTER_PREREQUISITES.md).
2. **Firebase is configured** — `flutterfire configure` (or manual config) done; `google-services.json` and `GoogleService-Info.plist` in place.
3. **Backend is deployed (if using Cloud Functions)** — From repo root: `cd services/firebase && firebase deploy --only functions` so `recordCheckIn` is available. See `services/firebase/README.md` if needed.

---

## 1. Run locally (development)

Use this for day-to-day development and quick testing.

```bash
cd apps/mobile
flutter pub get
flutter run
```

- Pick a device or emulator when prompted.
- **Debug build** — Hot reload works; app talks to your configured Firebase project (oklah-mvp or emulator).

To use Firebase Emulator for Auth/Firestore/Functions:

- Start emulators: `cd services/firebase && firebase emulators:start --only auth,firestore,functions`
- Point the app at the emulator (e.g. in `main.dart` or via environment): see [Firebase Emulator docs](https://firebase.google.com/docs/emulator-suite/connect_and_prototype).

---

## 2. Build for release

Release builds are required for distribution (testers, stores, or Firebase App Distribution).

### 2.1 Android

**Release APK (installable file for testing):**

```bash
cd apps/mobile
flutter build apk --release
```

- Output: `build/app/outputs/flutter-apk/app-release.apk`
- Install on a device: `adb install build/app/outputs/flutter-apk/app-release.apk`

**Release App Bundle (AAB) for Play Store):**

```bash
flutter build appbundle --release
```

- Output: `build/app/outputs/bundle/release/app-release.aab`
- Use this when uploading to Google Play (internal testing, closed/open testing, or production).

**Signing (release):**  
Android release builds must be signed. Either:

- Let Flutter use a **debug keystore** for local testing (default; not for store).
- Configure **release signing**: create a keystore, then in `android/app/build.gradle` set `signingConfigs.release` and `buildTypes.release.signingConfig`. See [Flutter Android signing](https://docs.flutter.dev/deployment/android#signing-the-app).

### 2.2 iOS

**Requirements:** macOS, Xcode, Apple Developer account (for device testing and App Store).

**Release build (archive for TestFlight or App Store):**

```bash
cd apps/mobile
flutter build ios --release
```

Then in Xcode:

1. Open `ios/Runner.xcworkspace`.
2. Select **Product → Archive**.
3. Use the Organizer to **Distribute App** (Ad Hoc, TestFlight, or App Store).

**Signing:**  
Configure signing in Xcode (Runner target → Signing & Capabilities) with your Team and provisioning profile.

---

## 3. Deploy options at this stage

“Deploy” here means **getting the built app onto devices** for testers or stores.

### 3.1 Manual install (fastest for a few testers)

- **Android:** Share the `app-release.apk` (or AAB if using Play internal testing). Testers install the APK (enable “Install from unknown sources” if needed).
- **iOS:** Use **Ad Hoc** or **TestFlight** from Xcode Organizer after archiving. Ad Hoc requires registered device UDIDs; TestFlight is easier for external testers.

### 3.2 Firebase App Distribution (recommended for MVP)

Good for handing builds to QA or internal testers without going through the stores.

1. **Install Firebase CLI** (if not already): `npm install -g firebase-tools` and `firebase login`.
2. **Add App Distribution to the app:**  
   [Firebase App Distribution for Flutter](https://firebase.google.com/docs/app-distribution/flutter/distribute) — add the `firebase_app_distribution` package or use the Firebase CLI to upload builds.
3. **Android:** Upload the APK or AAB:
   ```bash
   firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
     --app FIREBASE_ANDROID_APP_ID \
     --groups "testers"
   ```
   Get `FIREBASE_ANDROID_APP_ID` from Firebase Console → Project settings → Your apps → Android app.
4. **iOS:** Upload the `.ipa` (export from Xcode archive, e.g. Ad Hoc or Development). Firebase docs describe the exact command for iOS.

Testers receive an email/link to install the app.

### 3.3 Google Play (internal / internal testing)

1. Build: `flutter build appbundle --release`.
2. In [Google Play Console](https://play.google.com/console), create the app (if needed), then upload `app-release.aab` under **Release → Testing → Internal testing** (or Closed testing).
3. Add testers by email; they install via the Play Store link.

### 3.4 Apple TestFlight

1. Archive in Xcode and upload to App Store Connect (Distribute App → App Store Connect).
2. In [App Store Connect](https://appstoreconnect.apple.com/), enable the build for **TestFlight** and add internal/external testers.

---

## 4. Environment and configuration

- **Firebase project:** The app uses the project configured at build time (e.g. via `firebase_options.dart` from `flutterfire configure`). For release, use the same **oklah-mvp** project (or a dedicated staging project if you create one).
- **Debug vs release:**  
  - Debug: `flutter run`; easier to debug; can point to emulators.  
  - Release: `flutter build apk|appbundle|ios --release`; optimized; use for distribution and performance testing.
- **Version:** Set `version` in `apps/mobile/pubspec.yaml` (e.g. `0.1.0+1`). The `+1` is the build number; bump it for each store or distribution build.

---

## 5. Optional: CI/CD later (GitHub Actions)

PROJECT-CONFIG says “Firebase CLI + GitHub Actions (optional later)”. When you add automation:

- **Build:** Run `flutter build apk` / `flutter build appbundle` / `flutter build ios` in a runner (e.g. macOS for iOS).
- **Deploy:** Use Firebase App Distribution action or `firebase appdistribution:distribute` to upload the artifact; or upload AAB/IPA to Play/App Store via their APIs or official actions.

A minimal GitHub Actions workflow could:

1. On push to `main` (or a `release` branch), run `flutter pub get` and `flutter build apk --release`.
2. Upload the APK to Firebase App Distribution (or store) using secrets for Firebase token and app IDs.

---

## 6. Checklist at this stage

- [ ] Prerequisites done: Flutter project at `apps/mobile/` with Android/iOS, Firebase configured ([FLUTTER_PREREQUISITES.md](FLUTTER_PREREQUISITES.md)).
- [ ] Backend: Firebase Functions deployed if the app uses `recordCheckIn` (`firebase deploy --only functions` from `services/firebase`).
- [ ] Android release: Signing configured (if distributing); `flutter build apk` or `flutter build appbundle` runs without errors.
- [ ] iOS release (if needed): Xcode signing and archive work; TestFlight or Ad Hoc set up.
- [ ] Distribution: Choose one of manual install, Firebase App Distribution, Play internal testing, or TestFlight, and share the build with testers.

When you add store releases or GitHub Actions, extend this guide with the exact commands and secrets you use.
