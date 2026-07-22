import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'add_quiz_controller.dart';

class AddQuizPage extends ConsumerWidget {
  final String difficulty;
  final bool isEdit;
  final String quizId;

  const AddQuizPage({
    super.key,
    this.difficulty = '',
    this.isEdit = false,
    this.quizId = '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(addQuizControllerProvider);
    final controller = ref.read(addQuizControllerProvider.notifier);

    // Initialize with difficulty if provided
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (difficulty.isNotEmpty && !isEdit) {
        controller.setDifficulty(difficulty);
      }
      if (isEdit && quizId.isNotEmpty) {
        controller.loadQuizForEdit(quizId);
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgimg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    isEdit ? 'Edit Quiz' : 'Add New Quiz',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                
                if (difficulty.isNotEmpty || quizState.difficulty.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Difficulty: ${difficulty.isNotEmpty ? difficulty : quizState.difficulty}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 40),

                // Question TextField
                TextFormField(
                  key: ValueKey(quizState.question),
                  initialValue: quizState.question,
                  onChanged: controller.setQuestion,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF460C16)),
                  decoration: InputDecoration(
                    hintText: '+ Add Question',
                    hintStyle: const TextStyle(color: Color(0xFF460C16)),
                    filled: true,
                    fillColor: const Color(0xFFF0DDE0),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Option TextFields
                for (int i = 0; i < 4; i++) ...[
                  _QuizTextField(
                    key: ValueKey('${quizState.options[i]}-$i'),
                    hint: '+ Option ${i + 1}',
                    initialValue: quizState.options[i],
                    onChanged: (val) => controller.setOption(i, val),
                  ),
                  const SizedBox(height: 20),
                ],

                // Correct Answer Selection
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0DDE0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Select Correct Answer:',
                        style: TextStyle(
                          color: Color(0xFF460C16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: List.generate(4, (index) {
                          return ChoiceChip(
                            label: Text('Option ${index + 1}'),
                            selected: quizState.correctAnswerIndex == index,
                            onSelected: (selected) {
                              if (selected) {
                                controller.setCorrectAnswer(index);
                              }
                            },
                            selectedColor: const Color(0xFF460C16),
                            labelStyle: TextStyle(
                              color: quizState.correctAnswerIndex == index 
                                ? Colors.white 
                                : const Color(0xFF460C16),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: _roundedButtonStyle(),
                        onPressed: () => context.go('/quiz-list'),
                        child: const SizedBox(
                          width: 70,
                          child: Center(
                            child: Text('Cancel', textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: _roundedButtonStyle(),
                        onPressed: () async {
                          final success = await controller.save(
                            difficulty: difficulty.isNotEmpty ? difficulty : quizState.difficulty,
                            isEdit: isEdit,
                            quizId: quizId,
                          );
                          
                          if (success && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(isEdit ? 'Quiz updated successfully!' : 'Quiz saved successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            context.go('/quiz-list');
                          }
                        },
                        child: const SizedBox(
                          width: 70,
                          child: Center(
                            child: Text('Save', textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _roundedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF0DDE0),
      foregroundColor: const Color(0xFF460C16),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class _QuizTextField extends StatelessWidget {
  final String hint;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _QuizTextField({
    super.key,
    required this.hint,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Color(0xFF460C16)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF460C16)),
        filled: true,
        fillColor: const Color(0xFFF0DDE0),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
