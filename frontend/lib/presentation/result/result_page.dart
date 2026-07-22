import 'package:flutter/material.dart';
import '../core/widgets/SidebarDrawer.dart';
import 'result_widgets.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final void Function(String) onDrawerItemClick;
  final VoidCallback onBackClick;
  final VoidCallback onNextClick;
  final String currentPage;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.onDrawerItemClick,
    required this.onBackClick,
    required this.onNextClick,
    required this.currentPage,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isDrawerOpen = false;

  void openDrawer() => setState(() => isDrawerOpen = true);

  void closeDrawer() => setState(() => isDrawerOpen = false);

  void handleDrawerItemClick(String item) {
    closeDrawer();
    if (item != widget.currentPage) {
      Future.microtask(() {
        widget.onDrawerItemClick(item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              onPressed: openDrawer,
            ),
          ),
          // Pass only context and widget here
          body: buildResultBody(context, widget),
        ),
        if (isDrawerOpen)
          SidebarDrawer(
            items: const ["ጥያቄ - ፈተና ክብደት", "መለያ", "የፈተና ማህደር", "ንባብ"],
            onItemClick: handleDrawerItemClick,
            onClose: closeDrawer,
          ),
      ],
    );
  }
}
