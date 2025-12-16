import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/video_state.dart';
import '../widgets/video_card.dart';

/// 短视频 Feed 页
class VideoFeedPage extends ConsumerStatefulWidget {
  const VideoFeedPage({Key? key}) : super(key: key);

  @override
  ConsumerState<VideoFeedPage> createState() => _VideoFeedPageState();
}

class _VideoFeedPageState extends ConsumerState<VideoFeedPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(videoListProvider);
    final notifier = ref.read(videoListProvider.notifier);

    return Scaffold(
      body: state.isLoading && state.videos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.videos.isEmpty
              ? const Center(child: Text('暂无视频'))
              : PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: state.videos.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final video = state.videos[index];
                    return VideoCard(
                      video: video,
                      isCurrent: index == _currentIndex,
                      onLike: () {
                        notifier.toggleLike(video.id);
                      },
                    );
                  },
                ),
    );
  }
}

