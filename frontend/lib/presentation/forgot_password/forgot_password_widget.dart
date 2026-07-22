import 'package:flutter/material.dart';
import '../../application/auth/usecases/verify_user_exists.dart';
import '../../infrastructure/auth/repositories/auth_repository_impl.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordWidget extends StatefulWidget {
  final void Function(String username) onSuccess;

  const ForgotPasswordWidget({super.key, required this.onSuccess});

  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final TextEditingController _usernameController = TextEditingController();
  late final ForgotPasswordController controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final repo = UserRepositoryImpl();
    final useCase = CheckUsernameExistsUseCase(repo);
    controller = ForgotPasswordController(useCase);
  }

  Future<void> _handleSubmit() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      _showMessage('Please enter a username.');
      return;
    }

    setState(() => _isLoading = true);

    final exists = await controller.verifyUsername(username);

    setState(() => _isLoading = false);

    if (exists) {
      widget.onSuccess(username);
    } else {
      _showMessage('Username does not exist.');
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
        Text("የመለስተ መርሃግብር", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 20),
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            hintText: "መለያ",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        SizedBox(height: 20),
        _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _handleSubmit,
                child: Text("ቀጣይ"),
              ),
      ],
    );
  }
}
