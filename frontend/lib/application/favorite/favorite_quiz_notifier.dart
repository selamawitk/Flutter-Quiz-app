import 'package:flutter/material.dart';
import '../../domain/favorite/favorite_quiz.dart';
import 'continue_favorite_quiz.dart';
import 'view_favorite_quiz.dart';

class FavoriteQuizNotifier extends ChangeNotifier {
  String _firstQuizId = '';
  String _secondQuizId = '';

  final ViewFavoriteQuiz viewUseCase;
  final ContinueFavoriteQuiz continueUseCase;

  FavoriteQuizNotifier({
    required this.viewUseCase,
    required this.continueUseCase,
  });

  void updateFirstQuizId(String id) {
    _firstQuizId = id;
  }

  void updateSecondQuizId(String id) {
    _secondQuizId = id;
  }

  void onViewClicked() {
    final quiz = FavoriteQuiz(id: _firstQuizId, title: '', description: '');
    viewUseCase.call(quiz);
  }

  void onContinueClicked() {
    final quiz = FavoriteQuiz(id: _secondQuizId, title: '', description: '');
    continueUseCase.call(quiz);
  }
}
