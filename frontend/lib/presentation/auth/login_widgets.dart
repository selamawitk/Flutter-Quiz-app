import 'package:flutter/material.dart';

class LoginInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final Key? testKey;

  const LoginInputField({
    super.key,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    required this.onChanged,
    this.testKey,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: testKey,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54),
        filled: true,
        fillColor: const Color(0xFFFFE6EC),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}

class RoleRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final Function(String) onChanged;

  const RoleRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: (v) => onChanged(v!),
          fillColor: WidgetStateProperty.all(Color(0xFFF0DDE0)),
        ),
        Text(
          value == 'student' ? 'ተማሪ' : 'አስተማሪ',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
