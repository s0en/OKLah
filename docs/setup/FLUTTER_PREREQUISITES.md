# Flutter project setup — Prerequisites guide

This guide covers the three prerequisites (P-01, P-02, P-03) required before implementing **anonymous onboarding** and **first check-in** in the OKLah mobile app.

**References:** `docs/fsd/onboarding/anonymous_onboarding/tasks.md`, `docs/fsd/onboarding/first_checkin/tasks.md`, `PROJECT-CONFIG.md`

---

## Overview

| Prerequisite | Description | Task ref |
|-------------|-------------|----------|
| **P-01** | Flutter app scaffold at `apps/mobile/` (entry point, routing, theme, forui integration) | D-01 |
| **P-02** | Firebase SDK integrated (firebase_core, firebase_auth, etc.; `Firebase.initializeApp()` in main) | D-02 |
| **P-03** | Local storage solution (shared_preferences or flutter_secure_storage) | D-03 |

---

## P-01: Flutter app scaffold

### 1.1 Install Flutter

- Use the **stable** channel per PROJECT-CONFIG.md.
- Install Flutter: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
- Verify: `flutter doctor`

### 1.2 Create or complete the app at `apps/mobile/`

The repo already has `apps/mobile/` with `lib/`, `pubspec.yaml`, and `test/`. To get full platform support (Android/iOS):

**Option A — Add platforms to existing folder (recommended if you want to keep current `lib/`):**

```bash
cd apps/mobile
flutter create . --project-name oklah --org com.oklah
```

- Use `--org com.oklah` to match PROJECT-CONFIG (Android: `com.oklah.app`, iOS: `com.oklah.app`).
- Flutter will add `android/`, `ios/`, `web/`, etc. and leave `lib/` and `pubspec.yaml` intact (it may add a default `lib/main.dart`; keep or merge with the existing one).

**Option B — New project then merge:**

```bash
flutter create apps/mobile --project-name oklah --org com.oklah
# Then copy lib/* and test/* from your current apps/mobile into the new one, and merge pubspec.yaml dependencies.
```

### 1.3 Set app IDs (PROJECT-CONFIG)

- **Android:** In `android/app/build.gradle`, set `applicationId` to `com.oklah.app`.
- **iOS:** In `ios/Runner.xcodeproj` or Xcode, set Bundle Identifier to `com.oklah.app`.

### 1.4 Entry point and routing

- Entry point: `lib/main.dart` — already calls `Firebase.initializeApp()` then `runApp(OKLahApp())`.
- Root widget: `lib/app.dart` — `OKLahApp` and `_OnboardingGate` (3-state routing) are already wired.

### 1.5 Theme and forui (optional)

- Theme: `MaterialApp` in `app.dart` uses `ThemeData(useMaterial3: true)`.
- **forui:** Per PROJECT-CONFIG, use forui for UI components. When the forui package is available, add it to `pubspec.yaml` and use forui widgets in onboarding screens (placeholder comment is in pubspec).

### 1.6 Verify P-01

```bash
cd apps/mobile
flutter pub get
flutter analyze
flutter run   # Pick a device/emulator
```

---

## P-02: Firebase SDK integration

### 2.1 Firebase project

- Use project ID **oklah-mvp** (PROJECT-CONFIG).
- In [Firebase Console](https://console.firebase.google.com/), create or select the project and enable:
  - **Authentication** → Sign-in method → **Anonymous** (enable).
  - **Firestore** (if not already enabled).
  - **Cloud Functions** (for `recordCheckIn`).

### 2.2 Add FlutterFire plugins and config

- Install FlutterFire CLI:  
  `dart pub global activate flutterfire_cli`
- From repo root:  
  `cd apps/mobile && flutterfire configure`
- Choose project **oklah-mvp**; this generates:
  - `lib/firebase_options.dart` (and/or platform config files),
  - and ensures Android/iOS config files are referenced.

### 2.3 Initialize Firebase in app

- In `lib/main.dart`, initialize with options (if you use `flutterfire configure`):

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const OKLahApp());
}
```

- If you skip `flutterfire configure`, keep the current `Firebase.initializeApp()` (no options); ensure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are in place from Firebase Console.

### 2.4 Packages (already in pubspec.yaml)

- `firebase_core`
- `firebase_auth` (anonymous sign-in)
- `firebase_analytics`
- `cloud_firestore` (first_checkin, recovery)
- `cloud_functions` (recordCheckIn)

No extra steps unless you add a new Firebase package.

### 2.5 Android: Google services

- In `android/app/build.gradle`, ensure the Google Services plugin is applied (usually in root `build.gradle` and `app/build.gradle` as in the default Flutter template).
- Place `google-services.json` (from Firebase Console → Project settings → Your apps) in `android/app/`.

### 2.6 iOS: GoogleService-Info.plist

- Download `GoogleService-Info.plist` from Firebase Console and add it to `ios/Runner/` in Xcode (e.g. drag into Runner target).

### 2.7 Verify P-02

- Run the app; the onboarding gate should run (it will call `FirebaseAuth.instance.currentUser` and may show disclosure or first-checkin stub).
- No runtime errors on startup about Firebase not being initialized.

---

## P-03: Local storage solution

### 3.1 Package choice

- **shared_preferences** — already in `pubspec.yaml`; used for the `onboarding_complete` flag and routing gate.
- **flutter_secure_storage** — optional for sensitive data (e.g. tokens); add if you need it later.

### 3.2 Usage in this repo

- **Onboarding router** (`lib/features/onboarding/services/onboarding_router.dart`): reads `onboarding_complete` via SharedPreferences (key `onboarding_complete`).
- **Check-in recording** (`lib/features/onboarding/services/checkin_recording_service.dart`): writes `onboarding_complete = true` after successful first check-in.

No extra setup is required beyond `shared_preferences` in pubspec; ensure `flutter pub get` has been run.

### 3.3 Verify P-03

- Run the app; the gate reads from SharedPreferences (defaults to no key → first-time flow).
- After first check-in is implemented, completing a check-in should set the flag and subsequent launches should go to main experience.

---

## Checklist summary

- [ ] **P-01** Flutter installed (stable); `apps/mobile` has platform folders (`android/`, `ios/`); app IDs set to `com.oklah.app`; `flutter run` works.
- [ ] **P-02** Firebase project `oklah-mvp` exists; Anonymous Auth enabled; `flutterfire configure` (or manual config) done; `Firebase.initializeApp()` in main; no startup errors.
- [ ] **P-03** `shared_preferences` in pubspec; used by onboarding router and check-in recording service; `flutter pub get` run.

When all three are done, you can proceed with the remaining implementation tasks from the anonymous onboarding and first check-in task lists.

---

## Troubleshooting

### "Running pod install..." seems stuck (macOS or iOS)

When you run `flutter run` and choose **macOS** (or iOS), the first time CocoaPods runs it has to download and resolve many Firebase-related pods. This can take **15–30+ minutes** and often looks stuck while it is still working.

- **Option 1 — Wait:** Let it run; do not cancel. First-time pod install with Firebase is slow.
- **Option 2 — See progress:** In a terminal, run:
  ```bash
  cd apps/mobile/macos
  pod install --verbose
  ```
  You will see which pod is being fetched. When it finishes, run `flutter run` again (it will be faster next time).
- **Option 3 — Use iOS simulator:** For quicker iteration, run `flutter run` and choose an **iOS** simulator instead of macOS; iOS pod install can still be slow the first time but is often faster than macOS.
- **Check:** iOS Podfile has `platform :ios, '13.0'`; macOS Podfile has `platform :osx, '10.15'`. Both match Firebase requirements.

### macOS: "Operation not permitted" / "Lost connection to device" after launch

If the app builds and launches on macOS but then logs a network error (`NSPOSIXErrorDomain Code=1 "Operation not permitted"`) and Flutter reports "Lost connection to device", the app sandbox is blocking **outgoing** network access. Firebase needs outbound HTTPS.

**Fix:** Add the outgoing network entitlement to the macOS Runner:

- **`macos/Runner/DebugProfile.entitlements`** and **`macos/Runner/Release.entitlements`** must include:
  ```xml
  <key>com.apple.security.network.client</key>
  <true/>
  ```
  This is already added in this project. Then run `flutter run` again (debug uses DebugProfile.entitlements).

### macOS: "firebase_auth/keychain-error" when signing in (e.g. Continue on privacy)

Firebase Auth stores credentials in the Keychain. Sandboxed macOS apps need the **keychain-access-groups** entitlement or you get "An error occurred when accessing the keychain".

**Fix:** Add keychain-access-groups to both entitlement files (already done in this project):

- **`macos/Runner/DebugProfile.entitlements`** and **`macos/Runner/Release.entitlements`** include:
  ```xml
  <key>keychain-access-groups</key>
  <array>
    <string>$(AppIdentifierPrefix)com.oklah.app</string>
  </array>
  ```
  Use your app’s bundle ID (`com.oklah.app`). `$(AppIdentifierPrefix)` is filled by Xcode from your **Development Team**. You must also enable development signing or the build will fail (see next section).

### macOS: "Runner has entitlements that require signing with a development certificate"

After adding **keychain-access-groups** (for Firebase Auth), the macOS app must be **signed** with a development certificate. If you see:

`"Runner" has entitlements that require signing with a development certificate. Enable development signing in the Signing & Capabilities editor.`

**Fix (one-time):**

1. Open the macOS project in Xcode:
   ```bash
   open apps/mobile/macos/Runner.xcworkspace
   ```
2. In the left sidebar, click the **Runner** project (blue icon), then select the **Runner** target.
3. Open the **Signing & Capabilities** tab.
4. Under **Signing**, check **"Automatically manage signing"**.
5. In **Team**, choose your Apple ID team (e.g. "Your Name (Personal Team)"). If none appears, click **"Add an Account…"** and sign in with your Apple ID; a free Personal Team will be created.
6. Close Xcode. From the project root run:
   ```bash
   cd apps/mobile && flutter run
   ```
   Choose **macOS** again; the build should succeed.

**If you don't want to set up signing yet:** Run on **Android** or **iOS Simulator** instead (`flutter run` and pick an Android device/emulator or an iOS simulator). Those platforms don't require this step for local debug.
