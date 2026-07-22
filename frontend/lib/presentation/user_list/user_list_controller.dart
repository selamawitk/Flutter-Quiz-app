import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersProvider = StateProvider<List<String>>((ref) {
  return List.generate(7, (_) => 'User1');
});
