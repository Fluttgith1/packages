import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  /// The path for the forgot password page.
  static const String path = 'forgot_password';

  /// The name for the forgot password page.
  static const String name = 'ForgotPassword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: const Center(
        child: Text('ForgotPassword Page'),
      ),
    );
  }
}
