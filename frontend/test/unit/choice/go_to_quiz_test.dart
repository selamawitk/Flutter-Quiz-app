import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/choice/usecases/go_to_quiz.dart';
import 'package:frontend/domain/choice/repositories/choice_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockChoiceRepository extends Mock implements ChoiceRepository {}

void main() {
  group('GoToQuiz', () {
    late MockChoiceRepository mockRepository;
    late GoToQuiz useCase;

    setUp(() {
      mockRepository = MockChoiceRepository();
      useCase = GoToQuiz(mockRepository);
    });

    test('calls repository.goToQuiz()', () async {
      when(() => mockRepository.goToQuiz())
          .thenAnswer((_) async => Future.value());

      await useCase.call();

      verify(() => mockRepository.goToQuiz()).called(1);
    });
  });
}
