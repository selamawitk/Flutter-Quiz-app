import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/profile/entities/profile.dart';
import '../../application/profile/usecases/fetch_profile.dart';

final profileControllerProvider = FutureProvider<Profile>((ref) async {
  final fetchProfile = ref.watch(fetchProfileProvider);
  return await fetchProfile();
});
