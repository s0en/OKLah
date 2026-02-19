import 'package:flutter/material.dart';

/// Placeholder until onboarding/first_checkin is implemented. Spec §4.4, Plan D-04 | Task T-13
class FirstCheckinStubScreen extends StatelessWidget {
  const FirstCheckinStubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'First check-in — coming soon',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
