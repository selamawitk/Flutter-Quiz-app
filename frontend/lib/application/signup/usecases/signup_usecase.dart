import '../../../domain/signup/entities/signup_entity.dart';
import '../../../domain/signup/repositories/signup_repository.dart';

class SignupUseCase {
  final SignupRepository repository;

  SignupUseCase(this.repository);

  Future<void> call(SignupData data) async {
    // Basic validation before calling repository
    if (data.username.isEmpty || data.password.isEmpty) {
      throw Exception('All fields are required.');
    }

    // Proceed with the signup operation
    await repository.signup(data);
  }
}
