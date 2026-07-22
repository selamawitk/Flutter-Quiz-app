import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final void Function(String) onChanged;
  final Key? testKey;

  const CustomInputField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    required this.onChanged,
    this.testKey,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: testKey,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFADADA),
        hintText: hint,
        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      textAlign: TextAlign.center,
      onChanged: onChanged,
    );
  }
}
