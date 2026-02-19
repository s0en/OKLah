import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'features/onboarding/services/onboarding_router.dart';
import 'features/onboarding/services/anonymous_auth_service.dart';
import 'features/onboarding/services/onboarding_analytics.dart';
import 'features/onboarding/screens/privacy_disclosure_screen.dart';
import 'features/onboarding/screens/first_checkin_stub_screen.dart';
// import 'features/onboarding/screens/first_checkin_screen.dart'; // when first_checkin implemented
// import 'features/main/screens/main_experience_stub_screen.dart'; // when main experience implemented

/// Root app widget. Wire onboarding_router into [MaterialApp] so gate runs before any screen.
/// FTheme wraps the app for forui widgets (PROJECT-CONFIG). Spec: anonymous_onboarding §4.1, VR-AO-002 | Task T-02
class OKLahApp extends StatelessWidget {
  const OKLahApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.neutral.light;
    return MaterialApp(
      title: 'OKLah',
      theme: theme.toApproximateMaterialTheme(),
      supportedLocales: FLocalizations.supportedLocales,
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      builder: (_, child) => FTheme(
        data: theme,
        child: FToaster(child: FTooltipGroup(child: child ?? const SizedBox.shrink())),
      ),
      home: const _OnboardingGate(),
    );
  }
}

/// Runs 3-state routing gate at startup; renders destination screen.
/// On disclosure Continue: session creation + navigate to first check-in (T-06, T-08, T-12).
class _OnboardingGate extends StatefulWidget {
  const _OnboardingGate();

  @override
  State<_OnboardingGate> createState() => _OnboardingGateState();
}

class _OnboardingGateState extends State<_OnboardingGate> {
  OnboardingRouteDestination? _overrideDestination;
  bool _loading = false;
  String? _error;
  final _authService = AnonymousAuthService();
  final _analytics = OnboardingAnalytics();

  Future<void> _onDisclosureContinue() async {
    if (_loading) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      _analytics.logPrivacyDisclosureAcknowledged();
      await _authService.createAnonymousSession();
      _analytics.logAnonymousSessionCreated();
      _analytics.logOnboardingCompleted();
      if (mounted) setState(() {
        _overrideDestination = OnboardingRouteDestination.firstCheckin;
        _loading = false;
      });
    } catch (e) {
      if (mounted) setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_overrideDestination != null) {
      switch (_overrideDestination!) {
        case OnboardingRouteDestination.firstCheckin:
          return const FirstCheckinStubScreen();
        case OnboardingRouteDestination.mainExperience:
          return const _MainExperiencePlaceholder();
        case OnboardingRouteDestination.privacyDisclosure:
          break;
      }
    }

    return FutureBuilder<OnboardingRouteDestination>(
      future: OnboardingRouter.resolveDestination(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final dest = snapshot.data ?? OnboardingRouteDestination.privacyDisclosure;
        switch (dest) {
          case OnboardingRouteDestination.privacyDisclosure:
            return PrivacyDisclosureScreen(
              onContinue: _loading ? null : _onDisclosureContinue,
              loading: _loading,
              error: _error,
            );
          case OnboardingRouteDestination.firstCheckin:
            return const FirstCheckinStubScreen();
          case OnboardingRouteDestination.mainExperience:
            return const _MainExperiencePlaceholder();
        }
      },
    );
  }
}

class _MainExperiencePlaceholder extends StatelessWidget {
  const _MainExperiencePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Main experience — coming soon', style: Theme.of(context).textTheme.titleLarge)),
    );
  }
}
