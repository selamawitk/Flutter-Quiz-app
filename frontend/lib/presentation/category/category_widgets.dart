// category_widgets.dart
import 'package:flutter/material.dart';

Widget buildBackButton(BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF0DDE0),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'ተመለስ',
          style: TextStyle(fontSize: 16),
        ),
      ),
    ),
  );
}