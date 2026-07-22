import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/choice/usecases/go_to_resources.dart';
import 'package:frontend/domain/choice/repositories/choice_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockChoiceRepository extends Mock implements ChoiceRepository {}

void main() {
  group('GoToResources', () {
    late MockChoiceRepository mockRepository;
    late GoToResources useCase;

    setUp(() {
      mockRepository = MockChoiceRepository();
      useCase = GoToResources(mockRepository);
    });

    test('calls repository.goToResources()', () async {
      when(() => mockRepository.goToResources())
          .thenAnswer((_) async => Future.value());

      await useCase.call();

      verify(() => mockRepository.goToResources()).called(1);
    });
  });
}
