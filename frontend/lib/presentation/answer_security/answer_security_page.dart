import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'answer_security_widget.dart';

class SecurityQuestionsPage extends StatelessWidget {
  final String username;

  const SecurityQuestionsPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SecurityQuestionsWidget(
          username: username,
          onSuccess: (resetToken) {
            context.go('/reset-password', extra: {
              'username': username,
              'resetToken': resetToken,
            });
          },
        ),
      ),
    );
  }
}
