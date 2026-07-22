import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'select_difficulty_controller.dart';

class SelectDifficultyPage extends ConsumerWidget {
  final void Function(String difficulty)? onDifficultySelected;

  const SelectDifficultyPage({super.key, this.onDifficultySelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedDifficultyProvider);
    final difficulties = ref.watch(difficultiesProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/bgimg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logoimg.jpg',
                      width: 160,
                      height: 140,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Select Difficulty',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Difficulty cards
                  Expanded(
                    child: ListView.builder(
                      itemCount: difficulties.length,
                      itemBuilder: (context, index) {
                        final difficulty = difficulties[index];
                        final isSelected = difficulty == selected;

                        final horizontalPadding = index < 3 ? 15.0 : 10.0;
                        final extraSpacing = index < 3 ? 6.0 : 0.0;

                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            6,
                            horizontalPadding,
                            6 + extraSpacing,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // Update state
                              ref.read(selectedDifficultyProvider.notifier).state = difficulty;

                              // Call external callback if provided
                              if (onDifficultySelected != null) {
                                onDifficultySelected!(difficulty);
                              }

                              // Navigate if needed
                              if (index < 3) {
                                Navigator.pushNamed(context, '/add_quiz');
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF460C16)
                                    : const Color(0xFFF0DDE0),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: Colors.transparent, width: 0),
                              ),
                              child: Center(
                                child: Text(
                                  difficulty,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : const Color(0xFF460C16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Bottom buttons
                  Transform.translate(
                    offset: const Offset(0, -50),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBottomButton(
                            text: 'Back',
                            backgroundColor: const Color(0xFFF5E8EA),
                            textColor: const Color(0xFF460C16),
                            onPressed: () => Navigator.pop(context),
                          ),
                          _buildBottomButton(
                            text: 'Next',
                            backgroundColor: const Color(0xFFF5E8EA),
                            textColor: const Color(0xFF460C16),
                            onPressed: () {
                              if (selected != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Selected: $selected')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please select a difficulty')),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) {
            if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
              return backgroundColor.withOpacity(0.8);
            }
            return backgroundColor;
          },
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 28, vertical: 5),
        ),
        minimumSize: WidgetStateProperty.all(const Size(0, 36)),
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
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
