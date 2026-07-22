import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/quiz/datasources/quiz_remote_data_source.dart';

void main() {
  late QuizRemoteDataSource dataSource;

  setUp(() {
    dataSource = QuizRemoteDataSource();
  });

  test('should return a list of quizzes', () async {
    final quizzes = await dataSource.getQuizzes();

    expect(quizzes, isA<List>());
    expect(quizzes.isNotEmpty, true);
  });
}
