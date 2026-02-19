import 'package:firebase_analytics/firebase_analytics.dart';

/// Emits 6 first check-in events. Spec §9 | Task T-20
class FirstCheckinAnalytics {
  FirstCheckinAnalytics([FirebaseAnalytics? analytics])
      : _analytics = analytics ?? FirebaseAnalytics.instance;

  final FirebaseAnalytics _analytics;

  Future<void> logFirstCheckinScreenShown() =>
      _analytics.logEvent(name: 'first_checkin_screen_shown');

  Future<void> logFirstCheckinAttempted() =>
      _analytics.logEvent(name: 'first_checkin_attempted');

  Future<void> logFirstCheckinCompleted() =>
      _analytics.logEvent(name: 'first_checkin_completed');

  Future<void> logFirstCheckinFailed() =>
      _analytics.logEvent(name: 'first_checkin_failed');

  Future<void> logFirstCheckinTimeElapsed(Duration elapsed) =>
      _analytics.logEvent(
        name: 'first_checkin_time_elapsed',
        parameters: {'seconds': elapsed.inSeconds},
      );

  Future<void> logTimezoneAnchored(String timezone, {bool isFallback = false}) =>
      _analytics.logEvent(
        name: 'timezone_anchored',
        parameters: {'timezone': timezone, 'is_fallback': isFallback},
      );
}
