import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation/app_router.dart';
import 'infrastructure/auth/auth_provider.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Create a container to initialize services before app starts
  final container = ProviderContainer();
  
  // Initialize authentication from storage
  await container.read(authControllerProvider).initAuth();

  runApp(
    ProviderScope(
      parent: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for auth state changes
    final authState = ref.watch(authStateProvider);
    
    return MaterialApp.router(
      title: 'Haleta App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
      // Use the router defined in app_router.dart
      routerConfig: router,
    );
  }
}