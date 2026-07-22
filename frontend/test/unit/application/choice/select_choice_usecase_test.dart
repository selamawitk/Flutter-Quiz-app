import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/choice/usecases/go_to_quiz.dart';
import 'package:frontend/application/choice/usecases/go_to_resources.dart';
import 'package:frontend/domain/choice/repositories/choice_repository.dart';

class MockChoiceRepository extends Mock implements ChoiceRepository {}

void main() {
  late MockChoiceRepository mockRepo;

  setUp(() {
    mockRepo = MockChoiceRepository();
  });

  group('GoToQuiz UseCase', () {
    test('should call goToQuiz on the repository', () async {
      final usecase = GoToQuiz(mockRepo);
      when(() => mockRepo.goToQuiz()).thenAnswer((_) async {});

      await usecase();

      verify(() => mockRepo.goToQuiz()).called(1);
    });
  });

  group('GoToResources UseCase', () {
    test('should call goToResources on the repository', () async {
      final usecase = GoToResources(mockRepo);
      when(() => mockRepo.goToResources()).thenAnswer((_) async {});

      await usecase();

      verify(() => mockRepo.goToResources()).called(1);
    });
  });
}
