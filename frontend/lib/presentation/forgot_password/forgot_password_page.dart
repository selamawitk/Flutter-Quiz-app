import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'forgot_password_widget.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgimg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ForgotPasswordWidget(
            onSuccess: (String username) {
              context.go('/answer-security', extra: {'username': username});
            },
          ),
        ),
      ),
    );
  }
}
