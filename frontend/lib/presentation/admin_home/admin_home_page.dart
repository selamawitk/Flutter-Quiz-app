import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'admin_home_controller.dart';
import 'admin_home_widgets.dart';

class AdminHomePage extends ConsumerWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(adminHomeControllerProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/bgimg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Logo at top center
                Center(
                  child: Image.asset(
                    'assets/images/logoimg.jpg',
                    width: 250,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 40),
                // Menu Buttons
                Column(
                  children: [
                    MenuButton(
                      text: 'User List',
                      onTap: () => controller.navigateToUserList(context),
                    ),
                    const SizedBox(height: 20),
                    MenuButton(
                      text: 'Quiz List',
                      onTap: () => controller.navigateToQuizList(context),
                    ),
                    const SizedBox(height: 20),
                    MenuButton(
                      text: 'Resource List',
                      onTap: () => controller.navigateToResourceList(context),
                    ),
                    const SizedBox(height: 50),
                    MenuButton(
                      text: 'Logout',
                      onTap: () => controller.logout(context),
                      narrow: true,
                      short: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
