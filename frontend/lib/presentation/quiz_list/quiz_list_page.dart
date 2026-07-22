import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/quiz_list/entities/quiz.dart';
import 'quiz_list_controller.dart';

class QuizListPage extends ConsumerWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(quizListProvider.notifier);
    final quizzes = ref.watch(quizListProvider);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/bgimg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logoimg.jpg',
                      width: 160,
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Title
                  const Text(
                    'Quiz List',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: quizzes.isEmpty
                        ? const Center(
                            child: Text(
                              'No quizzes found',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            itemCount: quizzes.length,
                            itemBuilder: (context, index) {
                              final quiz = quizzes[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                child: _buildQuizRow(context, quiz, controller),
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 20),
                  
                  // Bottom buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBottomButton(
                          text: 'Back',
                          backgroundColor: const Color(0xFFF5E8EA),
                          textColor: const Color(0xFF460C16),
                          onPressed: () => context.go('/admin-home'),
                        ),
                        _buildBottomButton(
                          text: '+ Create',
                          backgroundColor: const Color(0xFFF5E8EA),
                          textColor: const Color(0xFF460C16),
                          onPressed: () => context.go('/select-difficulty'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizRow(BuildContext context, Quiz quiz, QuizListController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5E8EA),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quiz.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF460C16),
                  ),
                ),
                Text(
                  'Difficulty: ${quiz.difficulty ?? "Unknown"}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF460C16),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _buildInnerButton(
                  text: 'Edit',
                  backgroundColor: const Color(0xFF460C16),
                  textColor: const Color(0xFFF5E8EA),
                  onPressed: () {
                    context.go('/add-quiz', extra: {
                      'isEdit': true,
                      'quizId': quiz.id,
                      'difficulty': quiz.difficulty ?? '',
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _buildInnerButton(
                  text: 'Remove',
                  backgroundColor: const Color(0xFF460C16),
                  textColor: const Color(0xFFF5E8EA),
                  onPressed: () => _showRemoveConfirmation(context, quiz, controller),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRemoveConfirmation(BuildContext context, Quiz quiz, QuizListController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Removal'),
          content: Text('Are you sure you want to remove "${quiz.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.removeQuiz(quiz.id);
              },
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInnerButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.pressed)) {
              return backgroundColor.withOpacity(0.8);
            }
            return backgroundColor;
          },
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        minimumSize: WidgetStateProperty.all(const Size(0, 32)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildBottomButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        minimumSize: WidgetStateProperty.all(const Size(100, 45)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
