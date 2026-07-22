import 'package:equatable/equatable.dart';

class StudyTopic extends Equatable {
  final String id;
  final String title;
  final String amharicTitle;
  final String description;
  final bool isAvailable;
  final int itemCount;

  const StudyTopic({
    required this.id,
    required this.title,
    required this.amharicTitle,
    required this.description,
    required this.isAvailable,
    required this.itemCount,
  });

  @override
  List<Object> get props => [
        id,
        title,
        amharicTitle,
        description,
        isAvailable,
        itemCount,
      ];
} 