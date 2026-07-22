import 'package:flutter/material.dart';
import '../../application/auth/usecases/reset_password.dart';
import '../../infrastructure/auth/repositories/auth_repository_impl.dart';
import 'reset_password_controller.dart';

// Separate PasswordInputField widget
class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;

  const PasswordInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.validator,
  });

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

// Separate ResetPasswordButton widget
class ResetPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const ResetPasswordButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator(color: Colors.white)
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              backgroundColor: Colors.white,
              foregroundColor: Colors.red[900],
            ),
            child: Text("Reset Password"),
          );
  }
}

class ResetPasswordWidget extends StatefulWidget {
  final String username;
  final String resetToken;
  final void Function() onSuccess;

  const ResetPasswordWidget({
    super.key,
    required this.username,
    required this.resetToken,
    required this.onSuccess,
  });

  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late final ResetPasswordController controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final repo = AuthRepositoryImpl();
    final useCase = ResetPasswordUseCase(repo);
    controller = ResetPasswordController(useCase, widget.username, widget.resetToken);
  }

  Future<void> _handleSubmit() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty) {
      _showMessage('Please enter a new password.');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Passwords do not match.');
      return;
    }

    setState(() => _isLoading = true);

    final success = await controller.resetPassword(password);

    setState(() => _isLoading = false);

    if (success) {
      _showMessage('Password reset successfully!');
      widget.onSuccess();
    } else {
      _showMessage('Failed to reset password. Please try again.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "የይለፍ ቃል ይቀይሩ",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 40),
        PasswordInputField(
          controller: _passwordController,
          labelText: "አዲስ የይለፍ ቃል",
          hintText: "አዲስ የይለፍ ቃል ያስገቡ",
        ),
        SizedBox(height: 20),
        PasswordInputField(
          controller: _confirmPasswordController,
          labelText: "የይለፍ ቃል ማረጋገጫ",
          hintText: "አዲስ የይለፍ ቃልዎን ያረጋግጡ",
        ),
        SizedBox(height: 30),
        ResetPasswordButton(
          onPressed: _handleSubmit,
          isLoading: _isLoading,
        ),
      ],
    );
  }
} 