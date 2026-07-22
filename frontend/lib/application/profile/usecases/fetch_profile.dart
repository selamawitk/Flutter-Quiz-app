import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/profile/entities/profile.dart';
import '../../../domain/profile/repositories/profile_repository.dart';
import '../../../infrastructure/profile/providers/profile_repository_provider.dart'; // ✅ Add this import

final fetchProfileProvider = Provider<FetchProfile>((ref) {
  final repository = ref.watch(profileRepositoryProvider); // ✅ Now recognized
  return FetchProfile(repository);
});

class FetchProfile {
  final ProfileRepository _repository;
  FetchProfile(this._repository);

  Future<Profile> call() {
    return _repository.fetchProfile();
  }
}
