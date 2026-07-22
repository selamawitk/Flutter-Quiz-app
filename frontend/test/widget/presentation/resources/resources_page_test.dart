import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/resources/resources_page.dart';
import 'package:frontend/presentation/resources/resources_controller.dart';
import 'package:frontend/domain/resources/entities/resource.dart';

void main() {
  testWidgets('ResourcesPage shows list of fake resources', (WidgetTester tester) async {
    // Define fake data
    final fakeResources = [
      Resource(
        id: '1',
        title: 'Fake Resource 1',
        description: 'Description 1',
        url: 'http://example.com/1',
      ),
      Resource(
        id: '2',
        title: 'Fake Resource 2',
        description: 'Description 2',
        url: 'http://example.com/2',
      ),
    ];

    // Create fake GetResources usecase
    Future<List<Resource>> fakeGetResources() async => fakeResources;

    // Create fake RemoveResource usecase
    Future<void> fakeRemoveResource(String id) async {}

    // Build the widget with overridden providers
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          getResourcesProvider.overrideWithValue(fakeGetResources),
          removeResourceProvider.overrideWithValue(fakeRemoveResource),
        ],
        child: const MaterialApp(
          home: ResourcesPage(),
        ),
      ),
    );

    // Wait for async data to load and UI to settle
    await tester.pumpAndSettle();

    // Verify the fake resource titles appear in the widget tree
    expect(find.text('Fake Resource 1'), findsOneWidget);
    expect(find.text('Fake Resource 2'), findsOneWidget);
  });
}

