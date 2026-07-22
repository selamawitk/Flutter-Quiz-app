import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'reset_password_widget.dart';

class ResetPasswordPage extends StatelessWidget {
  final String username;
  final String resetToken;
  
  const ResetPasswordPage({super.key, required this.username, required this.resetToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ResetPasswordWidget(
            username: username,
            resetToken: resetToken,
            onSuccess: () {
              context.go('/login', extra: {'message': 'Password reset successfully. Please login with your new password.'});
            },
          ),
        ),
      ),
    );
  }
} 