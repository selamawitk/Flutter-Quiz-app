import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/answer_security/datasources/answer_security_remote_data_source.dart';

void main() {
  group('AnswerSecurityRemoteDataSource', () {
    test('should be instantiable', () {
      final dataSource = AnswerSecurityRemoteDataSourceImpl();
      expect(dataSource, isA<AnswerSecurityRemoteDataSource>());
    });
  });
}
