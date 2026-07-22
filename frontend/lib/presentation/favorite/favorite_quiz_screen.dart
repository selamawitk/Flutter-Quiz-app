import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoriteQuizScreen extends StatelessWidget {
  const FavoriteQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7C1626),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7C1626),
        title: const Text(
          'የተመረጡ ፈተናዎች',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(
        child: Text(
          'የተመረጡ ፈተናዎች\n(Favorite Quizzes)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}