import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/reset_password/datasources/reset_password_remote_data_source.dart';

void main() {
  group('ResetPasswordRemoteDataSource', () {
    test('should be instantiable', () {
      final dataSource = ResetPasswordRemoteDataSourceImpl();
      expect(dataSource, isA<ResetPasswordRemoteDataSource>());
    });
  });
}
