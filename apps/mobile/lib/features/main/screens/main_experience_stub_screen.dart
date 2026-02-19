import 'package:flutter/material.dart';

/// Placeholder until main experience is implemented. Plan D-07, OI-06 | Task T-15
class MainExperienceStubScreen extends StatelessWidget {
  const MainExperienceStubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to OKLah — coming soon',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
