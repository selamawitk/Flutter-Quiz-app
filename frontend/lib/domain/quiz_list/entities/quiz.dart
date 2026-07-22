import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  final String id;
  final String title;
  final String? difficulty;

  const Quiz({
    required this.id,
    required this.title,
    this.difficulty,
  });

  @override
  List<Object?> get props => [id, title, difficulty];
} 