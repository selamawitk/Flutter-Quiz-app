
import 'favorite_quiz.dart';
abstract class FavoriteQuizRepository {
  Future<void> viewQuiz(FavoriteQuiz quiz);
  Future<void> continueQuiz(FavoriteQuiz quiz);
}
