import '../../../domain/choice/repositories/choice_repository.dart';

class GoToResources {
  final ChoiceRepository repository;

  GoToResources(this.repository);

  Future<void> call() async {
    await repository.goToResources();
  }
}
