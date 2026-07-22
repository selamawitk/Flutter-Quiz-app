import 'package:flutter/material.dart';
import '../core/widgets/SidebarDrawer.dart';
import '../core/widgets/option_card.dart'; // Ensure OptionCard is imported correctly
import 'category_widgets.dart';
import 'category_controller.dart';

class CategoryPage extends StatefulWidget {
  final void Function(String) onDifficultySelected;
  final void Function(String) onDrawerItemClick;
  final String currentPage;
  const CategoryPage({
    super.key,
    required this.onDifficultySelected,
    required this.onDrawerItemClick,
    required this.currentPage,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isDrawerOpen = false;
  late CategoryController controller;

  @override
  void initState() {
    super.initState();
    controller = CategoryController();
    controller.addListener(() {
      if (mounted) setState(() {});
    });
    controller.loadCategories();
  }

  @override
  void dispose() {
    // It's good practice to remove the specific listener you added.
    controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/bgimg.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, size: 28, color: Colors.white),
              onPressed: () => setState(() => isDrawerOpen = true),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    'assets/images/logoimg.jpg',
                    width: 180,
                    height: 180,
                  ),
                ),
                const SizedBox(height: 40),

                if (controller.isLoading)
                  const Center(child: CircularProgressIndicator())
                else ...controller.categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OptionCard(
                      title: category.name,
                      subtitle: '${category.quizCount} ጥያቄዎች',
                      // Corrected: Directly pass the onDifficultySelected callback.
                      // This assumes OptionCard's onClick takes a String argument.
                      onClick: widget.onDifficultySelected,
                    ),
                  );
                }),

                const Spacer(),
                buildBackButton(context),
                const SizedBox(height: 26),
              ],
            ),
          ),
        ),

        if (isDrawerOpen)
          SidebarDrawer(
            items: const [
              "ጥያቄ - ፈተና ክብደት",
              "መለያ",
              "የፈተና ማህደር",
              "ንባብ"
            ],
            onItemClick: (item) {
              setState(() => isDrawerOpen = false);

              if (item != widget.currentPage) {
                widget.onDrawerItemClick(item);
              }
            },
            onClose: () {
              setState(() => isDrawerOpen = false);
            },
          ),
      ],
    );
  }
}