import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'quiz_controller.dart';

class QuizContent extends StatelessWidget {
  final QuizViewModel viewModel;
  final VoidCallback onNextClick;
  final void Function(String) onOptionSelected;

  const QuizContent({
    super.key,
    required this.viewModel,
    required this.onNextClick,
    required this.onOptionSelected,
  });

  Color getOptionColor(String option) {
    final selectedOption = viewModel.selectedOption;
    final correctAnswer = viewModel.correctAnswer;

    if (selectedOption == null) {
      return const Color(0xFFF8DDE0);
    } else if (option == correctAnswer) {
      return const Color(0xFF4CAF50); // green for correct
    } else if (option == selectedOption && selectedOption != correctAnswer) {
      return const Color(0xFFFF5252); // red for wrong selection
    } else {
      return const Color(0xFFF8DDE0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionText = viewModel.questionText;
    final options = viewModel.options;

    return Stack(
      children: [
        Image.asset(
          'assets/images/background.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Question Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECEC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  questionText,
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),

              const SizedBox(height: 24),

              // Options list
              ...options.map(
                    (option) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton(
                    onPressed: () {
                      onOptionSelected(option);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: getOptionColor(option),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      option,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  viewModel.moveToNextQuestion();

                  GoRouter.of(context).go('/result', extra: {
                    'score': 9,
                    'total': 10,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF0DDE0),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'ቀጣይ',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
