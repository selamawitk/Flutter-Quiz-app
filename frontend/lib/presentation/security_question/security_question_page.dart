import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'security_question_controller.dart';
import '../../widgets/custom_button.dart';
import 'question_input.dart';
import 'package:go_router/go_router.dart';
import '../signup/signup_controller.dart';

class SecurityQuestionPage extends ConsumerWidget {
  const SecurityQuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(securityQuestionControllerProvider.notifier);
    final state = ref.watch(securityQuestionControllerProvider);
    
    // Get parameters from router
    final routerState = GoRouterState.of(context);
    final Map<String, dynamic>? extra = routerState.extra as Map<String, dynamic>?;
    final bool isSignup = extra?['isSignup'] as bool? ?? false;
    final String username = extra?['username'] as String? ?? '';
    final String password = extra?['password'] as String? ?? '';

    // Show error messages
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Image.asset('assets/images/logoimg.jpg', height: 80),
                const SizedBox(height: 16),
                Text(
                  isSignup 
                    ? 'የመለያ ዋስትና ለማረጋገጥ እነዚህን መረጃዎች ያስገቡ'
                    : 'የይለፍ ቃል በረሱ ጊዜ አካውንት መልሰው ለማግኘት እነዚህን መረጃዎች ያስገቡ',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                QuestionInput(hint: 'ጥያቄ 1', onChanged: controller.setQuestion1),
                const SizedBox(height: 16),
                QuestionInput(hint: 'መልስ 1', onChanged: controller.setAnswer1),
                const SizedBox(height: 16),
                QuestionInput(hint: 'ጥያቄ 2', onChanged: controller.setQuestion2),
                const SizedBox(height: 16),
                QuestionInput(hint: 'መልስ 2', onChanged: controller.setAnswer2),

                const SizedBox(height: 20),
                
                state.isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : CustomButton(
                      text: isSignup ? 'ተመዝገብ' : 'ቀጥል',
                      onPressed: () async {
                        if (isSignup) {
                          // Complete signup flow
                          final securityAnswers = {
                            state.question1: state.answer1,
                            state.question2: state.answer2,
                          };
                          
                          final success = await controller.submitAnswersForSignup(username, password, securityAnswers);
                          if (success) {
                            context.go('/choice');
                          }
                        } else {
                          // Continue forgot password flow  
                          final success = await controller.submitAnswers();
                          if (success) {
                            context.go('/reset-password', extra: {'username': username});
                          }
                        }
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 