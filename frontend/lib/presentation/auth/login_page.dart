import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'login_controller.dart';
import 'login_widgets.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(loginControllerProvider.notifier);
    final state = ref.watch(loginControllerProvider);
    
    // Check if we have a message in the router state
    final routerState = GoRouterState.of(context);
    final Map<String, dynamic>? extra = routerState.extra as Map<String, dynamic>?;
    final String? message = extra?['message'] as String?;
    
    // Show message if provided
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message))
        );
      }
      
      // Show error message if login failed
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!))
        );
      }
      
      // Navigate based on user role if authenticated
      if (state.isAuthenticated && state.userData != null) {
        final userRole = state.userData!['role'] as String? ?? 'student';
        if (userRole == 'admin') {
          context.go('/admin-home');
        } else {
          context.go('/choice');
        }
      }
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgimg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logoimg.jpg', height: 80),
              const SizedBox(height: 16),
              const Text('ለመግባት', style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              LoginInputField(
                icon: Icons.person, 
                hintText: 'ስም', 
                onChanged: vm.setUsername,
                testKey: const Key('login_username_field'),
              ),
              const SizedBox(height: 16),
              LoginInputField(
                icon: Icons.vpn_key, 
                hintText: 'የሚስጥር ቁጥር', 
                obscureText: true, 
                onChanged: vm.setPassword,
                testKey: const Key('login_password_field'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoleRadio(value: 'student', groupValue: state.role, onChanged: vm.setRole),
                  RoleRadio(value: 'admin', groupValue: state.role, onChanged: vm.setRole),
                ],
              ),
              const SizedBox(height: 24),
              state.isLoading 
                ? const CircularProgressIndicator(color: Colors.white)
                : CustomButton(
                    text: 'ግባ',
                    key: const Key('login_button'),
                    onPressed: () async {
                      await vm.login();
                    },
                  ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'ይለፍ ቃል ከረሱ', 
                onPressed: () => context.go('/forgot-password'),
              ),
              const SizedBox(height: 24),
              const Text('አካውንት የሎትም?', style: TextStyle(color: Color(0xFFF0DDE0))),
              const SizedBox(height: 8),
              CustomButton(
                text: 'ይመዝገቡ',
                key: const Key('signup_button'),
                onPressed: () => context.go('/signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
