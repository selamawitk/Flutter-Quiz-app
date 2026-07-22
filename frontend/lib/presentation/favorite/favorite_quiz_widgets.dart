import 'package:flutter/material.dart';

/// Contains reusable widgets for the favorite quiz screen
class FavoriteQuizWidgets {
  // Custom quiz input field widget
  static Widget quizInputField({
    required String hintText,
    required Function(String) onChanged,
    required Color fillColor,
  }) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintStyle: const TextStyle(color: Color(0xFF460C16)),
      ),
    );
  }

  // Custom action button widget
  static Widget actionButton({
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF741424)),
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
    required Color buttonBackground,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        actionButton(
          text: 'ተመልከት',
          onPressed: onViewPressed,
          backgroundColor: buttonBackground,
        ),
        actionButton(
          text: 'ቀጥል',
          onPressed: onContinuePressed,
          backgroundColor: buttonBackground,
        ),
      ],
    );
  }
}
