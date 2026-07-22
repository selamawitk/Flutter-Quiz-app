import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/result/datasources/result_remote_data_source.dart';

void main() {
  group('ResultRemoteDataSource', () {
    test('should be instantiable', () {
      final dataSource = ResultRemoteDataSourceImpl();
      expect(dataSource, isA<ResultRemoteDataSource>());
    });
  });
}
