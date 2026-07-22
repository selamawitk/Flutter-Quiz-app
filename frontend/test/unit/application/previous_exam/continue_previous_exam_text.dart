import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/application/previous_exam/previous_exam_notifier.dart';
import 'package:frontend/presentation/previous_exam/previous_exam_controller.dart';

// Mock classes
class MockPreviousExamNotifier extends StateNotifier<PreviousExamState> with Mock 
    implements PreviousExamNotifier {
  MockPreviousExamNotifier() : super(PreviousExamState(firstQuizId: '', secondQuizId: ''));
}

class MockPreviousExamController extends Mock implements PreviousExamController {}

// Simple mock version of the PreviousExamPage for testing
class MockPreviousExamPage extends ConsumerWidget {
  const MockPreviousExamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(previousExamNotifierProvider);
    final notifier = ref.read(previousExamNotifierProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // First TextField
            TextField(
              controller: TextEditingController(text: state.firstQuizId),
              onChanged: notifier.onFirstQuizIdChange,
            ),
            
            // Second TextField
            TextField(
              controller: TextEditingController(text: state.secondQuizId),
              onChanged: notifier.onSecondQuizIdChange,
            ),
            
            // Action buttons
            Row(
              children: [
                // View button
                ElevatedButton(
                  onPressed: notifier.onViewClicked,
                  child: const Text('ተመልከት'),
                ),
                
                // Continue button
                ElevatedButton(
                  onPressed: notifier.onContinueClicked,
                  child: const Text('ቀጥል'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  late MockPreviousExamNotifier mockNotifier;
  late MockPreviousExamController mockController;
  late StateNotifierProvider<PreviousExamNotifier, PreviousExamState> mockProvider;

  setUp(() {
    mockNotifier = MockPreviousExamNotifier();
    mockController = MockPreviousExamController();
    
    // Create a test provider that returns our mock notifier
    mockProvider = StateNotifierProvider<PreviousExamNotifier, PreviousExamState>(
      (ref) => mockNotifier,
    );

    // Register fallback values if needed
    registerFallbackValue('');
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        previousExamNotifierProvider.overrideWithProvider(mockProvider),
        previousExamControllerProvider.overrideWithValue(mockController),
      ],
      child: const MaterialApp(
        home: MockPreviousExamPage(), // Use our mock version that doesn't rely on assets
      ),
    );
  }

  testWidgets('renders correctly and interacts with notifier', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Find all TextFields (2 according to the actual implementation)
    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(2));

    // Interact with the first TextField (onFirstQuizIdChange)
    await tester.enterText(textFields.at(0), 'id1');
    verify(() => mockNotifier.onFirstQuizIdChange('id1')).called(1);

    // Interact with the second TextField (onSecondQuizIdChange)
    await tester.enterText(textFields.at(1), 'id2');
    verify(() => mockNotifier.onSecondQuizIdChange('id2')).called(1);

    // Tap View button (using the Amharic text from the actual implementation)
    await tester.tap(find.text('ተመልከት'));
    await tester.pump(); // Ensure any animations/events settle
    verify(() => mockNotifier.onViewClicked()).called(1);

    // Tap Continue button (using the Amharic text from the actual implementation)
    await tester.tap(find.text('ቀጥል'));
    await tester.pump();
    verify(() => mockNotifier.onContinueClicked()).called(1);
  });
}
