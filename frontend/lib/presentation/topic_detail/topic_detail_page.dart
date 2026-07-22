import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/study/topic_detail_notifier.dart';
import 'topic_detail_ctrl.dart';
import 'topic_detail_widget.dart';

class TopicDetailPage extends ConsumerStatefulWidget {
  final String topicId;
  final String topicTitle;
  final String topicAmharicTitle;

  const TopicDetailPage({
    super.key,
    required this.topicId,
    required this.topicTitle,
    required this.topicAmharicTitle,
  });

  @override
  ConsumerState<TopicDetailPage> createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends ConsumerState<TopicDetailPage> {
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePage();
    });
  }

  void _initializePage() {
    final controller = ref.read(topicDetailControllerProvider);
    controller.initializePage(widget.topicId);
  }

  void _onBackPressed() {
    final controller = ref.read(topicDetailControllerProvider);
    controller.onBackPressed();
    GoRouter.of(context).go('/study');
  }

  void _onRetryPressed() {
    final controller = ref.read(topicDetailControllerProvider);
    controller.onRetryPressed(widget.topicId);
  }

  void _onMenuToggle() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final topicDetailState = ref.watch(topicDetailNotifierProvider);

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
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF8B1538).withOpacity(0.8),
                const Color(0xFF5D1A33).withOpacity(0.9),
                const Color(0xFF2C1810).withOpacity(0.95),
              ],
            ),
          ),
          child: SafeArea(
            child: _buildContent(topicDetailState),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TopicDetailState state) {
    if (state.isLoading) {
      return Column(
        children: [
          TopicDetailHeader(
            title: widget.topicTitle,
            amharicTitle: widget.topicAmharicTitle,
            onMenuToggle: _onMenuToggle,
            isMenuOpen: _isMenuOpen,
          ),
          const Expanded(child: TopicDetailLoading()),
          TopicDetailBackButton(onPressed: _onBackPressed),
        ],
      );
    }

    if (state.error != null) {
      return Column(
        children: [
          TopicDetailHeader(
            title: widget.topicTitle,
            amharicTitle: widget.topicAmharicTitle,
            onMenuToggle: _onMenuToggle,
            isMenuOpen: _isMenuOpen,
          ),
          Expanded(
            child: TopicDetailError(
              error: state.error!,
              onRetry: _onRetryPressed,
            ),
          ),
          TopicDetailBackButton(onPressed: _onBackPressed),
        ],
      );
    }

    if (state.topicDetail != null) {
      return Column(
        children: [
          TopicDetailHeader(
            title: state.topicDetail!.title,
            amharicTitle: state.topicDetail!.amharicTitle,
            onMenuToggle: _onMenuToggle,
            isMenuOpen: _isMenuOpen,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: TopicDescriptionContent(
                topicDetail: state.topicDetail!,
              ),
            ),
          ),
          TopicDetailBackButton(onPressed: _onBackPressed),
        ],
      );
    }

    return Column(
      children: [
        TopicDetailHeader(
          title: widget.topicTitle,
          amharicTitle: widget.topicAmharicTitle,
          onMenuToggle: _onMenuToggle,
          isMenuOpen: _isMenuOpen,
        ),
        const Expanded(
          child: Center(
            child: Text(
              'ምንም ይዘት አልተገኘም።',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        TopicDetailBackButton(onPressed: _onBackPressed),
      ],
    );
  }
}
