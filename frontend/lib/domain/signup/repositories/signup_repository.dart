import '../entities/signup_entity.dart';

abstract class SignupRepository {
  Future<void> signup(SignupData data);
}
