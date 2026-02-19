import 'package:flutter/material.dart';

/// Privacy disclosure: 3 content points + Continue CTA. Block passive dismissal.
/// Spec §4.2, VR-AO-001, AC-AO-02, AC-AO-03 | Tasks T-04, T-05, T-06, T-10, T-14
class PrivacyDisclosureScreen extends StatelessWidget {
  const PrivacyDisclosureScreen({
    super.key,
    this.onContinue,
    this.loading = false,
    this.error,
  });

  final VoidCallback? onContinue;
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
                Text('Privacy', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 24),
                _contentPoint('OKLah does not collect personal information.'),
                _contentPoint('Data is stored locally on the device by default.'),
                _contentPoint('The experience is anonymous by design.'),
                if (error != null) ...[
                  const SizedBox(height: 16),
                  Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  FilledButton(onPressed: onContinue, child: const Text('Try Again')),
                ] else ...[
                  const Spacer(),
                  if (loading)
                    const Center(child: CircularProgressIndicator())
                  else
                    FilledButton(
                      onPressed: onContinue,
                      child: const Text('Continue'),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
