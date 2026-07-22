import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Import your widgets
import 'package:frontend/presentation/profile/profile_page.dart';

// Mock callback classes with correct call signatures
class MockStringCallback extends Mock {
  void call(String arg);
}

class MockVoidCallback extends Mock {
  void call();
}

void main() {
  late MockStringCallback mockOnDrawerItemClick;
  late MockVoidCallback mockOnBackClick;

  setUp(() {
    mockOnDrawerItemClick = MockStringCallback();
    mockOnBackClick = MockVoidCallback();

    // Register fallback value without generic type parameter
    registerFallbackValue('');
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ProfileScreen(
        onDrawerItemClick: mockOnDrawerItemClick.call,
        onBackClick: mockOnBackClick.call,
        currentPage: 'መለያ',
      ),
    );
  }

  testWidgets('drawer opens and item clicks call callback', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Tap menu button to open drawer
    final menuButton = find.byIcon(Icons.menu);
    expect(menuButton, findsOneWidget);

    await tester.tap(menuButton);
    await tester.pumpAndSettle();

    // Tap drawer item different from current page
    final drawerItem = find.text('ጥያቄ - ፈተና ክብደት');
    expect(drawerItem, findsOneWidget);

    await tester.tap(drawerItem);
    await tester.pumpAndSettle();

    verify(() => mockOnDrawerItemClick.call('ጥያቄ - ፈተና ክብደት')).called(1);
  });

  testWidgets('logout button calls onBackClick', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final logoutButton = find.byType(LogoutButton);
    expect(logoutButton, findsOneWidget);

    await tester.tap(logoutButton);
    await tester.pump();

    verify(() => mockOnBackClick.call()).called(1);
  });
}
