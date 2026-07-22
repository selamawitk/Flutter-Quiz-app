import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/choice/usecases/go_to_quiz.dart';
import '../../application/choice/usecases/go_to_resources.dart';
import '../../infrastructure/choice/repositories_impl/choice_repository_impl.dart';
import '../../infrastructure/choice/datasources/choice_remote_data_source.dart';

final choiceControllerProvider = Provider.family<ChoiceController, BuildContext>((ref, context) {
  final remoteDataSource = ChoiceRemoteDataSource(context);
  final repository = ChoiceRepositoryImpl(remoteDataSource);

  return ChoiceController(
    GoToQuiz(repository),
    GoToResources(repository),
  );
});

class ChoiceController {
  final GoToQuiz goToQuiz;
  final GoToResources goToResources;

  ChoiceController(this.goToQuiz, this.goToResources);

  void onQuizPressed() => goToQuiz();
  void onResourcePressed() => goToResources();
}
