import 'package:flutter/material.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  /// The path for the counter page.
  static const String path = '/counter';

  /// The name for the counter page.
  static const String name = 'Counter';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Counter Page'),
      ),
    );
  }
}
