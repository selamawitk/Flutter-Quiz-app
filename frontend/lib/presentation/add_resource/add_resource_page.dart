import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_resource_controller.dart';

class AddResourcePage extends ConsumerWidget {
  final bool isEdit;
  final String resourceId;
  
  const AddResourcePage({
    super.key,
    this.isEdit = false,
    this.resourceId = '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resourceState = ref.watch(addResourceControllerProvider);
    final controller = ref.read(addResourceControllerProvider.notifier);

    return Scaffold(
      body: SizedBox.expand( // Make sure container fills whole screen
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bgimg.jpg'), // background image
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logoimg.jpg',
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'Add resource',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // title text
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Topic',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // label text
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: resourceState.topic,
                    onChanged: controller.setTopic,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    decoration: _inputDecoration('Resource topic to be added...'),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Detail',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // label text
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: resourceState.detail,
                    onChanged: controller.setDetail,
                    maxLines: 10,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    decoration: _inputDecoration('Write details on the topic here...'),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      onPressed: controller.submit,
                      icon: const Icon(Icons.add, color: Color(0xFF460C16)),
                      label: const Text(
                        'Add',
                        style: TextStyle(color: Color(0xFF460C16)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF0DDE0),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
      filled: true,
      fillColor: const Color(0xFFF0DDE0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
    );
  }
}
