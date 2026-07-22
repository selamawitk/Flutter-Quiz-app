import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/custom_button.dart';
import 'signup_controller.dart';
import 'signup_widgets.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(signupControllerProvider.notifier);
    final state = ref.watch(signupControllerProvider);

    // Show error message if present
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
        controller.clearError();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Image.asset('assets/images/logoimg.jpg', height: 80),
              const SizedBox(height: 16),
              const Text('ለመመዝገብ', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              CustomInputField(
                hint: 'የተጠቃሚ ስም',
                icon: Icons.person,
                onChanged: controller.setUsername,
                testKey: const Key('signup_username_field'),
              ),
              const SizedBox(height: 10),

              CustomInputField(
                hint: 'የይለፍ ቃል',
                icon: Icons.vpn_key,
                obscureText: true,
                onChanged: controller.setPassword,
                testKey: const Key('signup_password_field'),
              ),
              const SizedBox(height: 20),

              state.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : CustomButton(
                      text: 'ቀጥል',
                      key: const Key('signup_continue_button'),
                      onPressed: () async {
                        final isValid = await controller.validateAndProceed();
                        if (isValid) {
                          context.go('/security-question', extra: {
                            'isSignup': true,
                            'username': state.username,
                            'password': state.password,
                          });
                        }
                      },
                    ),
              const SizedBox(height: 20),

              const Text('ከዚህ በፊት ተመዝግበዋል?', style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 8),
              CustomButton(
                text: 'ይግቡ',
                onPressed: () => context.go('/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
