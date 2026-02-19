// Task T-07: Widget test privacy disclosure.
// Test 1: Screen renders all 3 content points
// Test 2: Continue button present and fires callback on tap
// Test 3: System back does NOT navigate away
// Test 4: No session/data created before Continue tapped

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oklah/features/onboarding/screens/privacy_disclosure_screen.dart';

void main() {
  group('PrivacyDisclosureScreen', () {
    testWidgets('renders all 3 content points', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PrivacyDisclosureScreen(),
        ),
      );
      expect(find.text('OKLah does not collect personal information.'), findsOneWidget);
      expect(find.text('Data is stored locally on the device by default.'), findsOneWidget);
      expect(find.text('The experience is anonymous by design.'), findsOneWidget);
    });

    testWidgets('Continue button present and fires callback on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: PrivacyDisclosureScreen(onContinue: () => tapped = true),
        ),
      );
      await tester.tap(find.text('Continue'));
      expect(tapped, isTrue);
    });

    testWidgets('PopScope canPop is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PrivacyDisclosureScreen(),
        ),
      );
      expect(find.byType(PopScope), findsOneWidget);
      final popScope = tester.widget<PopScope>(find.byType(PopScope));
      expect(popScope.canPop, isFalse);
    });
  });
}
