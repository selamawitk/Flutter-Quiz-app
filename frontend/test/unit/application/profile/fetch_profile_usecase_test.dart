
import 'package:flutter_test/flutter_test.dart';

class FetchProfileUseCase {
  Future<String> fetchProfileName() async {
    // Simulate fetch
    return Future.value('ሰላማዊት');
  }
}

void main() {
  group('FetchProfileUseCase', () {
    late FetchProfileUseCase useCase;

    setUp(() {
      useCase = FetchProfileUseCase();
    });

    test('should fetch profile name correctly', () async {
      final result = await useCase.fetchProfileName();
      expect(result, 'ሰላማዊት');
    });
  });
}
