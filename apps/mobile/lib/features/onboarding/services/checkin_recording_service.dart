import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Sole writer of onboarding_complete. Records first check-in + timezone; writes flag on success. Spec §4.3, §4.5 | Task T-08, T-09
class CheckinRecordingService {
  static const _keyOnboardingComplete = 'onboarding_complete';

  Future<void> recordFirstCheckin() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw CheckinRecordingException('No auth session');

    final timezone = _captureTimezone();
    final callable = FirebaseFunctions.instance.httpsCallable('recordCheckIn');
    await callable.call<dynamic>({
      'timezone': timezone,
      'source': 'first_checkin',
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingComplete, true);
  }

  String _captureTimezone() {
    final name = DateTime.now().timeZoneName;
    if (name.isEmpty) return 'UTC';
    return name;
  }
}

class CheckinRecordingException implements Exception {
  CheckinRecordingException(this.message);
  final String message;
}
