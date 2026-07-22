import 'package:flutter_riverpod/flutter_riverpod.dart';

final difficultiesProvider = Provider<List<String>>((ref) {
  return ['Easy', 'Medium', 'Hard'];
});

final selectedDifficultyProvider = StateProvider<String?>((ref) => null);
