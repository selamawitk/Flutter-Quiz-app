import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/resources/entities/resource.dart';
import 'resources_controller.dart';
import '../add_resource/add_resource_page.dart';

class ResourcesPage extends ConsumerWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resourcesAsync = ref.watch(resourcesControllerProvider);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/bgimg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logoimg.jpg',
                      width: 160,
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Expanded(
                    child: resourcesAsync.when(
                      data: (resources) {
                        return ListView.builder(
                          itemCount: resources.length,
                          itemBuilder: (context, index) {
                            final resource = resources[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: _buildResourceRow(context, resource, index, ref),
                            );
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, _) =>
                          Center(child: Text('Error: $error')),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Transform.translate(
                    offset: const Offset(0, -25),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBottomButton(
                            text: 'Back',
                            backgroundColor: const Color(0xFFF5E8EA),
                            textColor: const Color(0xFF460C16),
                            onPressed: () => Navigator.pop(context),
                          ),
                          _buildBottomButton(
                            text: '+ Create',
                            backgroundColor: const Color(0xFFF5E8EA),
                            textColor: const Color(0xFF460C16),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const AddResourcePage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceRow(
      BuildContext context, Resource resource, int index, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
      decoration: BoxDecoration(
        color: const Color(0xFFF5E8EA),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            resource.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF460C16),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _buildInnerButton(
                  text: 'Edit',
                  backgroundColor: const Color(0xFF460C16),
                  textColor: const Color(0xFFF5E8EA),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddResourcePage()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _buildInnerButton(
                  text: 'Remove',
                  backgroundColor: const Color(0xFF460C16),
                  textColor: const Color(0xFFF5E8EA),
                  onPressed: () {
                    ref
                        .read(resourcesControllerProvider.notifier)
                        .removeResource(resource.id);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInnerButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.pressed)) {
              return backgroundColor.withOpacity(0.8);
            }
            return backgroundColor;
          },
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        ),
        minimumSize: WidgetStateProperty.all(const Size(0, 32)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildBottomButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        ),
        minimumSize: WidgetStateProperty.all(const Size(100, 45)),
        fixedSize: WidgetStateProperty.all(const Size(100, 45)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
