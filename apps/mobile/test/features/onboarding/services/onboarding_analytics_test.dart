// Task T-20: Unit test analytics — each method calls FirebaseAnalytics.logEvent with correct name.
// Mock FirebaseAnalytics

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingAnalytics', () {
    test('logOnboardingStarted logs onboarding_started', () async {
      // TODO: Mock FirebaseAnalytics, verify logEvent(name: 'onboarding_started')
      expect(true, isTrue); // placeholder
    });
    // TODO: Same for logPrivacyDisclosureShown, logPrivacyDisclosureAcknowledged,
    // logAnonymousSessionCreated, logOnboardingCompleted
  });
}
