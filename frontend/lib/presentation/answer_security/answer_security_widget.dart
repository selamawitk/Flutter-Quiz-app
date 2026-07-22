import 'package:flutter/material.dart';
import '../../application/auth/usecases/verify_security_answers.dart';
import '../../infrastructure/auth/repositories/auth_repository_impl.dart';
import 'answer_security_controller.dart';

class SecurityQuestionsWidget extends StatefulWidget {
  final String username;
  final void Function(String resetToken) onSuccess;

  const SecurityQuestionsWidget({
    super.key,
    required this.username,
    required this.onSuccess,
  });

  @override
  State<SecurityQuestionsWidget> createState() => _SecurityQuestionsWidgetState();
}

class _SecurityQuestionsWidgetState extends State<SecurityQuestionsWidget> {
  final _answer1Controller = TextEditingController();
  final _answer2Controller = TextEditingController();
  late final SecurityQuestionsController controller;

  late String question1;
  late String question2;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final repo = AuthRepositoryImpl();
    final useCase = VerifySecurityAnswersUseCase(repo);
    controller = SecurityQuestionsController(useCase, repo);

    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questions = await controller.getQuestionsForUser(widget.username);
    if (questions.length < 2) {
      _showMessage("መጠየቂያ ጥያቄዎች አልተገኙም።");
      return;
    }

    setState(() {
      question1 = questions.keys.elementAt(0);
      question2 = questions.keys.elementAt(1);
      isLoading = false;
    });
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _submit() async {
    final answers = {
      question1: _answer1Controller.text,
      question2: _answer2Controller.text,
    };

    final resetToken = await controller.verifyAnswers(widget.username, answers);
    if (resetToken.isNotEmpty) {
      widget.onSuccess(resetToken);
    } else {
      _showMessage("መልሶቹ ትክክል አይደሉም።");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: CircularProgressIndicator());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("የመለያዎን ደህንነት ጥያቄዎች ይመልሱ", style: TextStyle(fontSize: 18, color: Colors.white)),
        const SizedBox(height: 20),
        Text("ጥያቄ 1\n፡ $question1", style: TextStyle(color: Colors.white)),
        TextField(
          controller: _answer1Controller,
          decoration: _fieldDecoration(),
        ),
        const SizedBox(height: 20),
        Text("ጥያቄ 2\n፡ $question2", style: TextStyle(color: Colors.white)),
        TextField(
          controller: _answer2Controller,
          decoration: _fieldDecoration(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submit,
          child: const Text("ቀጣይ"),
        )
      ],
    );
  }

  InputDecoration _fieldDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
