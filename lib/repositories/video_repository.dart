import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/feed_video.dart';

/// 视频数据仓库
/// TODO(prod): 替换为真实视频 API 调用
class VideoRepository {
  static List<FeedVideo>? _cachedVideos;
  static List<LiveRoom>? _cachedLiveRooms;

  /// 加载视频列表
  Future<List<FeedVideo>> loadVideos() async {
    if (_cachedVideos != null) {
      return _cachedVideos!;
    }

    try {
      final String jsonString =
          await rootBundle.loadString('assets/mock/videos.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedVideos = jsonList
          .map((json) => FeedVideo.fromJson(json as Map<String, dynamic>))
          .toList();
      return _cachedVideos!;
    } catch (e) {
      return [];
    }
  }

  /// 根据 ID 获取视频
  Future<FeedVideo?> getVideoById(String id) async {
    final videos = await loadVideos();
    try {
      return videos.firstWhere((v) => v.id == id);
    } catch (e) {
      return null;
    }
  }

  /// 点赞/取消点赞
  Future<FeedVideo> toggleLike(String videoId) async {
    final videos = await loadVideos();
    final index = videos.indexWhere((v) => v.id == videoId);
    if (index != -1) {
      final video = videos[index];
      final newVideo = video.copyWith(
        isLiked: !video.isLiked,
        likeCount: video.isLiked ? video.likeCount - 1 : video.likeCount + 1,
      );
      _cachedVideos![index] = newVideo;
      return newVideo;
    }
    throw Exception('Video not found');
  }

  /// 加载直播间列表
  Future<List<LiveRoom>> loadLiveRooms() async {
    if (_cachedLiveRooms != null) {
      return _cachedLiveRooms!;
    }

    try {
      final String jsonString =
          await rootBundle.loadString('assets/mock/live_rooms.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedLiveRooms = jsonList
          .map((json) => LiveRoom.fromJson(json as Map<String, dynamic>))
          .toList();
      return _cachedLiveRooms!;
    } catch (e) {
      return [];
    }
  }

  /// 根据 ID 获取直播间
  Future<LiveRoom?> getLiveRoomById(String id) async {
    final rooms = await loadLiveRooms();
    try {
      return rooms.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  /// 模拟发送弹幕
  Future<DanmakuMessage> sendDanmaku({
    required String roomId,
    required String userId,
    required String userName,
    required String content,
  }) async {
    return DanmakuMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      roomId: roomId,
      userId: userId,
      userName: userName,
      content: content,
      timestamp: DateTime.now(),
    );
  }

  /// 模拟发送礼物
  Future<DanmakuMessage> sendGift({
    required String roomId,
    required String userId,
    required String userName,
    required String giftName,
  }) async {
    return DanmakuMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      roomId: roomId,
      userId: userId,
      userName: userName,
      content: '送出了 $giftName',
      type: 1,
      timestamp: DateTime.now(),
    );
  }
}

