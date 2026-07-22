import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';  // Use mocktail here

import 'package:frontend/application/resources/usecases/get_resources.dart';
import 'package:frontend/domain/resources/entities/resource.dart';
import 'package:frontend/domain/resources/repositories/resource_repository.dart';

class MockResourceRepository extends Mock implements ResourceRepository {}

void main() {
  late GetResources usecase;
  late MockResourceRepository mockRepository;

  setUp(() {
    mockRepository = MockResourceRepository();
    usecase = GetResources(mockRepository);

    // Register fallback values if needed for parameters in methods
    // (usually not needed if methods have no parameters or simple ones)
  });

  final resources = [
    Resource(
      id: '1',
      title: 'Intro to Flutter',
      description: 'Beginner PDF guide',
      url: 'https://example.com/flutter.pdf',
    ),
    Resource(
      id: '2',
      title: 'Dart Basics',
      description: 'Dart video tutorial',
      url: 'https://example.com/dart.mp4',
    ),
  ];

  test('should return list of resources from repository', () async {
    // Arrange
    when(() => mockRepository.getResources()).thenAnswer((_) async => resources);

    // Act
    final result = await usecase.call();

    // Assert
    expect(result, resources);
    verify(() => mockRepository.getResources()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should throw exception when repository fails', () async {
    when(() => mockRepository.getResources()).thenThrow(Exception('error'));

    expect(() => usecase.call(), throwsException);
  });
}


