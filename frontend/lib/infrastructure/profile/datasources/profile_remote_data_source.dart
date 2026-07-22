import '../../../domain/profile/entities/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<Profile> getProfile() async {
    // Simulate API call or fetch from storage
    await Future.delayed(const Duration(seconds: 1));
    return Profile(
      id: '1',
      name: 'ሰላማዊት',
      email: 'selamawit@example.com',
    );
  }
}
