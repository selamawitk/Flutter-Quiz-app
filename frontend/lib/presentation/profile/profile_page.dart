import 'package:flutter/material.dart';
import 'package:frontend/presentation/core/widgets/SidebarDrawer.dart';
import 'package:go_router/go_router.dart';

// Profile Widgets
class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56.0),
      child: ElevatedButton(
        onPressed: () => context.go('/edit-profile'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          "መገለጫዎን ይቀይሩ",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}

class ArchiveButton extends StatelessWidget {
  const ArchiveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        onPressed: () => context.go('/previous-exam'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 240, 221, 224),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("▅ ▇ ▃", style: TextStyle(fontSize: 12, color: Color(0xFF7C1626))),
            SizedBox(width: 16),
            Text("የፈተና ማህደር", style: TextStyle(fontSize: 18, color: Color(0xFF7C1626))),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        onPressed: () => context.go('/favorite-quiz'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 240, 221, 224),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          "🖤 የተመረጡ ፈተናዎች",
          style: TextStyle(fontSize: 18, color: Color(0xFF7C1626)),
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 240, 221, 224),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          "ከመለያ ውጣ",
          style: TextStyle(fontSize: 16, color: Color(0xFF7C1626)),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final void Function(String) onDrawerItemClick;
  final VoidCallback onBackClick;
  final String currentPage;

  const ProfileScreen({
    super.key,
    required this.onDrawerItemClick,
    required this.onBackClick,
    required this.currentPage,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDrawerOpen = false;

  void closeDrawer() {
    setState(() => isDrawerOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/bgimg.jpg', fit: BoxFit.cover),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Menu Button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () => setState(() => isDrawerOpen = true),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Icon(Icons.account_circle, size: 150, color: Color.fromARGB(255, 240, 221, 224)),
                const SizedBox(height: 24),
                const Text("ሰላማዊት", style: TextStyle(fontSize: 36, color: Colors.white)),
                const SizedBox(height: 16),
                const EditProfileButton(),
                const SizedBox(height: 26),
                const ArchiveButton(),
                const SizedBox(height: 8),
                const FavoriteButton(),
                const Spacer(),
                Image.asset('assets/images/logoimg.jpg', width: 170, height: 170),
                const SizedBox(height: 10),
                LogoutButton(onPressed: widget.onBackClick),
              ],
            ),
          ),
        ),
        if (isDrawerOpen) ...[
          GestureDetector(
            onTap: closeDrawer,
            child: Container(color: Colors.black.withValues(alpha: 0.3)),
          ),
          SidebarDrawer(
            items: const ["ጥያቄ - ፈተና ክብደት", "መለያ", "የፈተና ማህደር", "ንባብ"],
            onItemClick: (item) {
              closeDrawer();
              if (item != widget.currentPage) {
                widget.onDrawerItemClick(item);
              }
            },
            onClose: closeDrawer,
          ),
        ],
      ],
    );
  }
} 