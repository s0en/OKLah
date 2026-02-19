import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 3-state routing gate destinations. Spec §4.1, E-AO-004 | Task T-01
enum OnboardingRouteDestination {
  privacyDisclosure,
  firstCheckin,
  mainExperience,
}

/// Read-only routing service. Checks Firebase Auth + onboarding_complete at launch.
/// Does NOT write any flags. Spec §4.1 invariant | Task T-01
class OnboardingRouter {
  static const _keyOnboardingComplete = 'onboarding_complete';

  /// Returns destination: privacyDisclosure (first time), firstCheckin (session, no flag), mainExperience (session + flag).
  /// Edge case: flag true but no session → treat as first time (privacyDisclosure).
  static Future<OnboardingRouteDestination> resolveDestination() async {
    final user = FirebaseAuth.instance.currentUser;
    final prefs = await SharedPreferences.getInstance();
    final complete = prefs.getBool(_keyOnboardingComplete) ?? false;

    if (user == null) return OnboardingRouteDestination.privacyDisclosure;
    if (complete) return OnboardingRouteDestination.mainExperience;
    return OnboardingRouteDestination.firstCheckin;
  }
}
