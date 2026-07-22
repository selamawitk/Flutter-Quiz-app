import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/category/datasources/category_remote_data_source.dart';

void main() {
  late CategoryRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = CategoryRemoteDataSourceImpl();
  });

  test('should return list of categories', () async {
    // act
    final result = await dataSource.getCategories();

    // assert
    expect(result, isA<List>());
    expect(result.length, 3);
    expect(result[0].name, 'ጀማሪ');
    expect(result[0].imageUrl, 'assets/images/beginner.png');
    expect(result[0].quizCount, 3);
  });
}
