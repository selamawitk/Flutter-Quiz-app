import 'package:flutter/material.dart';

/// Contains reusable widgets for the previous exam screen
class PreviousExamWidgets {
  // Custom quiz input field widget
  static Widget quizTextField({
    required String hintText,
    required String value,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: TextEditingController(text: value),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFFFF0F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintStyle: const TextStyle(color: Color(0xFF460C16)),
      ),
    );
  }

  // Header logo widget
  static Widget headerLogo() {
    return Image.asset(
      'assets/logoimg.jpg',
      height: 150,
    );
  }
  
  // Title widget
  static Widget titleText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
  
  // Action buttons row
  static Widget actionButtonsRow({
    required VoidCallback onViewPressed,
    required VoidCallback onContinuePressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFE4E1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onViewPressed,
          child: const Text(
            'ተመልከት',
            style: TextStyle(color: Color(0xFF741424)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFE4E1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onContinuePressed,
          child: const Text(
            'ቀጥል',
            style: TextStyle(color: Color(0xFF741424)),
          ),
        ),
      ],
    );
  }
} 