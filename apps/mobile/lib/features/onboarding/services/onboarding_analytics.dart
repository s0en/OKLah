import 'package:firebase_analytics/firebase_analytics.dart';

/// Emits 5 onboarding events. Spec §9 | Task T-18
class OnboardingAnalytics {
  OnboardingAnalytics([FirebaseAnalytics? analytics])
      : _analytics = analytics ?? FirebaseAnalytics.instance;

  final FirebaseAnalytics _analytics;

  Future<void> logOnboardingStarted() =>
      _analytics.logEvent(name: 'onboarding_started');

  Future<void> logPrivacyDisclosureShown() =>
      _analytics.logEvent(name: 'privacy_disclosure_shown');

  Future<void> logPrivacyDisclosureAcknowledged() =>
      _analytics.logEvent(name: 'privacy_disclosure_acknowledged');

  Future<void> logAnonymousSessionCreated() =>
      _analytics.logEvent(name: 'anonymous_session_created');

  Future<void> logOnboardingCompleted() =>
      _analytics.logEvent(name: 'onboarding_completed');
}
