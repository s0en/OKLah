// Basic Flutter widget test for OKLah app.
// OKLah uses OKLahApp (onboarding gate); no counter. This smoke test verifies a core screen builds
// without initializing Firebase (which requires platform channels in full app tests).

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:oklah/features/onboarding/screens/privacy_disclosure_screen.dart';

void main() {
  testWidgets('Privacy disclosure screen builds', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: FThemes.neutral.light.toApproximateMaterialTheme(),
        builder: (_, child) => FTheme(
          data: FThemes.neutral.light,
          child: child ?? const SizedBox.shrink(),
        ),
        home: const PrivacyDisclosureScreen(),
      ),
    );

    expect(find.text('Privacy'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
