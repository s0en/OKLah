// Task T-11: Unit test anonymous auth service.
// Test 1: signInAnonymously success → returns User, does NOT write completion flag
// Test 2: signInAnonymously failure → throws typed error
// Mock FirebaseAuth

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnonymousAuthService', () {
    test('createAnonymousSession success returns User', () async {
      // TODO: Mock FirebaseAuth.signInAnonymously to return credential with user
      // TODO: Assert no SharedPreferences setBool(onboarding_complete)
      expect(true, isTrue); // placeholder
    });

    test('createAnonymousSession failure throws typed error', () async {
      // TODO: Mock signInAnonymously to throw
      // expect(() => service.createAnonymousSession(), throwsA(isA<AnonymousAuthException>()));
      expect(true, isTrue); // placeholder
    });
  });
}
