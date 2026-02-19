import 'package:firebase_auth/firebase_auth.dart';

/// Creates anonymous session. Does NOT set onboarding_complete (owned by first_checkin). Spec §4.3, §4.4 | Task T-08
class AnonymousAuthService {
  Future<User> createAnonymousSession() async {
    final cred = await FirebaseAuth.instance.signInAnonymously();
    final user = cred.user;
    if (user == null) throw AnonymousAuthException('No user returned');
    return user;
  }
}

class AnonymousAuthException implements Exception {
  AnonymousAuthException(this.message);
  final String message;
}
