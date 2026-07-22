import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/add_resource/usecases/create_resource.dart';
import 'package:frontend/domain/add_resource/repositories/add_resource_repository.dart';
import 'package:frontend/domain/core/failures/app_failure.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockAddResourceRepository extends Mock implements AddResourceRepository {}

void main() {
  late CreateResourceUseCase useCase;
  late MockAddResourceRepository mockRepo;

  setUp(() {
    mockRepo = MockAddResourceRepository();
    useCase = CreateResourceUseCase(mockRepo);
  });

  test('should call repository to create resource with correct parameters', () async {
    const testTitle = 'Test Resource Title';
    const testDescription = 'This is a test description.';
    const testLink = 'http://testlink.com';

    when(() => mockRepo.createResource(
      title: testTitle,
      description: testDescription,
      link: testLink,
    )).thenAnswer((_) async => right(unit));

    final result = await useCase(
      title: testTitle,
      description: testDescription,
      link: testLink,
    );

    expect(result, right(unit));
    verify(() => mockRepo.createResource(
      title: testTitle,
      description: testDescription,
      link: testLink,
    )).called(1);
  });

  test('should return failure when repository call fails', () async {
    const testTitle = 'Test Resource Title';
    const testDescription = 'This is a test description.';
    const testLink = 'http://testlink.com';
    const testFailure = ServerFailure('Server error occurred');

    when(() => mockRepo.createResource(
      title: testTitle,
      description: testDescription,
      link: testLink,
    )).thenAnswer((_) async => left(testFailure));

    final result = await useCase(
      title: testTitle,
      description: testDescription,
      link: testLink,
    );

    expect(result, left(testFailure));
    verify(() => mockRepo.createResource(
      title: testTitle,
      description: testDescription,
      link: testLink,
    )).called(1);
  });
}


