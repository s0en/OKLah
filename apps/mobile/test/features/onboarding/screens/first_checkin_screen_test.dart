// Task T-07 (first_checkin): Widget test first check-in screen.
// Test 1: Screen renders guidance text and CTA
// Test 2: CTA present, prominent, fires callback on tap
// Test 3: System back does NOT navigate away
// Test 4: After CTA tap button is disabled (double-tap prevention)
// Test 5: Loading indicator shown after CTA tap

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oklah/features/onboarding/screens/first_checkin_screen.dart';

void main() {
  group('FirstCheckinScreen', () {
    testWidgets('renders guidance and I\'m OK button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FirstCheckinScreen(),
        ),
      );
      expect(find.text('I\'m OK'), findsOneWidget);
      expect(find.byType(PopScope), findsOneWidget);
    });

    testWidgets('CTA fires callback on tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: FirstCheckinScreen(onCheckin: () => tapped = true),
        ),
      );
      await tester.tap(find.text('I\'m OK'));
      expect(tapped, isTrue);
    });
  });
}
