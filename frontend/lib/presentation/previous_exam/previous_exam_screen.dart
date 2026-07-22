import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreviousExamScreen extends StatelessWidget {
  const PreviousExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7C1626),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7C1626),
        title: const Text(
          'የፈተና ማህደር',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(
        child: Text(
          'የፈተና ማህደር\n(Previous Exams Archive)',
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

// Alias for the test
class PreviousExamPage extends PreviousExamScreen {
  const PreviousExamPage({super.key});
}