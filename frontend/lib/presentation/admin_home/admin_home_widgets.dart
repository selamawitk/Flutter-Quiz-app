import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool narrow;
  final bool short;

  const MenuButton({
    super.key,
    required this.text,
    required this.onTap,
    this.narrow = false,
    this.short = false,
  });

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = narrow ? 100 : 40;
    double verticalPadding = short ? 5 : 9; // Reduced by 5 units

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF5E8EA),
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF460C16),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
