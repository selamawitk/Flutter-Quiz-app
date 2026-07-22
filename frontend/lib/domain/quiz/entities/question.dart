import 'package:equatable/equatable.dart';

class Option extends Equatable {
  final String id;
  final String text;
  final bool isCorrect;

  const Option({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  @override
  List<Object> get props => [id, text, isCorrect];
}

class Question extends Equatable {
  final String id;
  final String text;
  final List<Option> options;
  final int points;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    this.points = 1,
  });

  @override
  List<Object> get props => [id, text, options, points];
} 