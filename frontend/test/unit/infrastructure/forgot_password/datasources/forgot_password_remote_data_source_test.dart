import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/forgot_password/datasources/forgot_password_remote_data_source.dart';

void main() {
  group('ForgotPasswordRemoteDataSource', () {
    test('should be instantiable', () {
      final dataSource = ForgotPasswordRemoteDataSourceImpl();
      expect(dataSource, isA<ForgotPasswordRemoteDataSource>());
    });
  });
}
