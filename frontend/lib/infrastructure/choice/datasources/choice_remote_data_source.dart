
import 'package:flutter/material.dart';

class ChoiceRemoteDataSource {
  final BuildContext context;

  ChoiceRemoteDataSource(this.context);

  Future<void> navigateToQuiz() async {
    Navigator.pushNamed(context, '/quiz');
  }

  Future<void> navigateToResources() async {
    Navigator.pushNamed(context, '/resources');
  }
}
