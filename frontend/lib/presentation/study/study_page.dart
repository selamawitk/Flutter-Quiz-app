import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/study/entities/study_topic.dart';
import 'study_controller.dart';
import 'study_provider.dart';

class StudyPage extends ConsumerStatefulWidget {
  const StudyPage({super.key});

  @override
  ConsumerState<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends ConsumerState<StudyPage> {
  @override
  void initState() {
    super.initState();
    // Initialize page when widget loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(studyControllerProvider).initializePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final combinedState = ref.watch(combinedStudyStateProvider);
    final controller = ref.watch(studyControllerProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Add overlay to ensure text readability
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF8B1538).withOpacity(0.8),
                const Color(0xFFB91C3C).withOpacity(0.8),
                const Color(0xFFDC2626).withOpacity(0.7),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header with menu and logo
                _buildHeader(controller, combinedState.isMenuOpen),
                
                // Logo section
                _buildLogo(),
                
                // Topics list
                Expanded(
                  child: _buildTopicsList(combinedState, controller),
                ),
                
                // Back button
                _buildBackButton(controller),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(StudyController controller, bool isMenuOpen) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Hamburger menu
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: isMenuOpen ? Border.all(color: Colors.white, width: 2) : null,
            ),
            child: IconButton(
              icon: Icon(
                isMenuOpen ? Icons.close : Icons.menu,
                color: Colors.white,
                size: 28,
              ),
              onPressed: controller.onMenuToggle,
            ),
          ),
          const Spacer(),
          // Menu icon from assets if available
          if (isMenuOpen)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'ሜኑ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Logo with radiating lines effect
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Center(
              child: Text(
                'ሀ',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black26,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: const Text(
              'ሀ ለ ታ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black26,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicsList(CombinedStudyState state, StudyController controller) {
    if (state.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
            SizedBox(height: 16),
            Text(
              'ጭነው...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    if (state.error != null) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Color(0xFF8B1538),
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'ስህተት: ${state.error}',
                style: const TextStyle(
                  color: Color(0xFF8B1538),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }

    if (state.topics.isEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Text(
            'ምንም የጥናት ርዕሶች አይገኙም',
            style: TextStyle(
              color: Color(0xFF8B1538),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView.builder(
        itemCount: state.topics.length,
        itemBuilder: (context, index) {
          final topic = state.topics[index];
          final isSelected = state.selectedTopic?.id == topic.id;
          return _buildTopicButton(topic, controller, isSelected);
        },
      ),
    );
  }

  Widget _buildTopicButton(StudyTopic topic, StudyController controller, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        elevation: isSelected ? 8 : 4,
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () => controller.onTopicSelected(topic, context),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: isSelected 
                  ? Colors.white 
                  : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isSelected 
                    ? const Color(0xFF8B1538)
                    : Colors.white.withOpacity(0.3),
                width: isSelected ? 3 : 2,
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: const Color(0xFF8B1538).withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ] : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${topic.amharicTitle} - ${topic.title}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF8B1538),
                      shadows: isSelected ? [
                        const Shadow(
                          blurRadius: 2.0,
                          color: Colors.black12,
                          offset: Offset(1.0, 1.0),
                        ),
                      ] : null,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isSelected ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isSelected ? Icons.keyboard_arrow_down : Icons.arrow_forward_ios,
                    color: Color(0xFF8B1538).withOpacity(0.7),
                    size: isSelected ? 24 : 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(StudyController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(25),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () => controller.onBackPressed(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color(0xFF8B1538).withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: const Color(0xFF8B1538),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'ተመለስ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8B1538),
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
}