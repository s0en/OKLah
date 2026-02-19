import 'package:flutter/material.dart';

/// First check-in: guidance text + "I'm OK" CTA, loading state, PopScope. Spec §4.2, E-FC-005 | Tasks T-04, T-05, T-06
class FirstCheckinScreen extends StatelessWidget {
  const FirstCheckinScreen({
    super.key,
    this.onCheckin,
    this.loading = false,
    this.error,
  });

  final VoidCallback? onCheckin;
  final bool loading;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Text('First check-in', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                Text(
                  'Tap below when you\'re OK. This records your first daily check-in.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                if (error != null) ...[
                  Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  const SizedBox(height: 16),
                ],
                if (loading)
                  const Center(child: CircularProgressIndicator())
                else
                  FilledButton(
                    onPressed: onCheckin,
                    child: const Text('I\'m OK'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
