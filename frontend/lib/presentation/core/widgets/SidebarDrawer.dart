import 'package:flutter/material.dart';

class SidebarDrawer extends StatelessWidget {
  final List<String> items;
  final void Function(String) onItemClick;
  final VoidCallback onClose;  // Add this

  const SidebarDrawer({
    super.key,
    required this.items,
    required this.onItemClick,
    required this.onClose,  // require it
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/sidebar.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: onClose,  // Use callback to close sidebar
            ),
            const SizedBox(height: 160),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 22.0, left: 15, right: 15),
              child: ElevatedButton(
                onPressed: () {
                  onClose(); // Close sidebar first
                  Future.microtask(() {
                    onItemClick(item);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFCE8EE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 44),
                ),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 15, color: Color(0xFF771F1E)),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
