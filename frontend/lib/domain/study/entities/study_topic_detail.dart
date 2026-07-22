import 'package:equatable/equatable.dart';

class StudyTopicDetail extends Equatable {
  final String id;
  final String title;
  final String amharicTitle;
  final String description;
  final String amharicDescription;
  final List<String> examples;
  final List<String> rules;
  final int itemCount;
  final bool isAvailable;

  const StudyTopicDetail({
    required this.id,
    required this.title,
    required this.amharicTitle,
    required this.description,
    required this.amharicDescription,
    required this.examples,
    required this.rules,
    required this.itemCount,
    required this.isAvailable,
  });

  @override
  List<Object> get props => [
        id,
        title,
        amharicTitle,
        description,
        amharicDescription,
        examples,
        rules,
        itemCount,
        isAvailable,
      ];
} 