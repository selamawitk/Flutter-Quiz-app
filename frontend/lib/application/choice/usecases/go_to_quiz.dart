
import '../../../domain/choice/repositories/choice_repository.dart';

class GoToQuiz {
  final ChoiceRepository repository;

  GoToQuiz(this.repository);

  Future<void> call() async {
    await repository.goToQuiz();
  }
}
