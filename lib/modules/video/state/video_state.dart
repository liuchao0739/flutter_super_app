import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/feed_video.dart';
import '../../../repositories/video_repository.dart';

/// 视频列表状态
class VideoListState {
  final List<FeedVideo> videos;
  final bool isLoading;
  final String? error;

  VideoListState({
    this.videos = const [],
    this.isLoading = false,
    this.error,
  });

  VideoListState copyWith({
    List<FeedVideo>? videos,
    bool? isLoading,
    String? error,
  }) {
    return VideoListState(
      videos: videos ?? this.videos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 视频列表状态管理
class VideoListNotifier extends StateNotifier<VideoListState> {
  final VideoRepository _repository = VideoRepository();

  VideoListNotifier() : super(VideoListState()) {
    loadVideos();
  }

  Future<void> loadVideos() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final videos = await _repository.loadVideos();
      state = state.copyWith(
        videos: videos,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> toggleLike(String videoId) async {
    try {
      await _repository.toggleLike(videoId);
      await loadVideos();
    } catch (e) {
      // 处理错误
    }
  }
}

final videoListProvider =
    StateNotifierProvider<VideoListNotifier, VideoListState>((ref) {
  return VideoListNotifier();
});

/// 单个视频 Provider
final videoProvider =
    FutureProvider.family<FeedVideo?, String>((ref, id) async {
  final repository = VideoRepository();
  return await repository.getVideoById(id);
});

/// 直播间列表状态
class LiveRoomListState {
  final List<LiveRoom> rooms;
  final bool isLoading;
  final String? error;

  LiveRoomListState({
    this.rooms = const [],
    this.isLoading = false,
    this.error,
  });

  LiveRoomListState copyWith({
    List<LiveRoom>? rooms,
    bool? isLoading,
    String? error,
  }) {
    return LiveRoomListState(
      rooms: rooms ?? this.rooms,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 直播间列表状态管理
class LiveRoomListNotifier extends StateNotifier<LiveRoomListState> {
  final VideoRepository _repository = VideoRepository();

  LiveRoomListNotifier() : super(LiveRoomListState()) {
    loadLiveRooms();
  }

  Future<void> loadLiveRooms() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final rooms = await _repository.loadLiveRooms();
      state = state.copyWith(
        rooms: rooms,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final liveRoomListProvider =
    StateNotifierProvider<LiveRoomListNotifier, LiveRoomListState>((ref) {
  return LiveRoomListNotifier();
});

