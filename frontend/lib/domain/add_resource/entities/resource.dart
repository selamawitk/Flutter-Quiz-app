import 'package:equatable/equatable.dart';

class ResourceSubmission extends Equatable {
  final String id;
  final String title;
  final String url;

  const ResourceSubmission({
    required this.id,
    required this.title,
    required this.url,
  });

  @override
  List<Object> get props => [id, title, url];
}
