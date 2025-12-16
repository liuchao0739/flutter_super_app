/// 视频 Feed 模型
class FeedVideo {
  final String id;
  final String title;
  final String? description;
  final String videoUrl;
  final String coverUrl;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final bool isLiked;
  final int duration; // 秒
  final List<String> tags;
  final DateTime publishTime;
  final Map<String, dynamic>? extra;

  FeedVideo({
    required this.id,
    required this.title,
    this.description,
    required this.videoUrl,
    required this.coverUrl,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.isLiked = false,
    required this.duration,
    required this.tags,
    required this.publishTime,
    this.extra,
  });

  factory FeedVideo.fromJson(Map<String, dynamic> json) {
    return FeedVideo(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      videoUrl: json['videoUrl'] as String,
      coverUrl: json['coverUrl'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorAvatar: json['authorAvatar'] as String?,
      likeCount: json['likeCount'] as int? ?? 0,
      commentCount: json['commentCount'] as int? ?? 0,
      shareCount: json['shareCount'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      duration: json['duration'] as int? ?? 0,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      publishTime: DateTime.parse(json['publishTime'] as String),
      extra: json['extra'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'coverUrl': coverUrl,
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'isLiked': isLiked,
      'duration': duration,
      'tags': tags,
      'publishTime': publishTime.toIso8601String(),
      'extra': extra,
    };
  }

  FeedVideo copyWith({
    String? id,
    String? title,
    String? description,
    String? videoUrl,
    String? coverUrl,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    bool? isLiked,
    int? duration,
    List<String>? tags,
    DateTime? publishTime,
    Map<String, dynamic>? extra,
  }) {
    return FeedVideo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      coverUrl: coverUrl ?? this.coverUrl,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      isLiked: isLiked ?? this.isLiked,
      duration: duration ?? this.duration,
      tags: tags ?? this.tags,
      publishTime: publishTime ?? this.publishTime,
      extra: extra ?? this.extra,
    );
  }
}

/// 直播模型
class LiveRoom {
  final String id;
  final String title;
  final String coverUrl;
  final String streamerId;
  final String streamerName;
  final String? streamerAvatar;
  final int viewerCount;
  final int likeCount;
  final bool isLive;
  final String? streamUrl;
  final List<String> tags;
  final Map<String, dynamic>? extra;

  LiveRoom({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.streamerId,
    required this.streamerName,
    this.streamerAvatar,
    this.viewerCount = 0,
    this.likeCount = 0,
    this.isLive = true,
    this.streamUrl,
    required this.tags,
    this.extra,
  });

  factory LiveRoom.fromJson(Map<String, dynamic> json) {
    return LiveRoom(
      id: json['id'] as String,
      title: json['title'] as String,
      coverUrl: json['coverUrl'] as String,
      streamerId: json['streamerId'] as String,
      streamerName: json['streamerName'] as String,
      streamerAvatar: json['streamerAvatar'] as String?,
      viewerCount: json['viewerCount'] as int? ?? 0,
      likeCount: json['likeCount'] as int? ?? 0,
      isLive: json['isLive'] as bool? ?? true,
      streamUrl: json['streamUrl'] as String?,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      extra: json['extra'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'coverUrl': coverUrl,
      'streamerId': streamerId,
      'streamerName': streamerName,
      'streamerAvatar': streamerAvatar,
      'viewerCount': viewerCount,
      'likeCount': likeCount,
      'isLive': isLive,
      'streamUrl': streamUrl,
      'tags': tags,
      'extra': extra,
    };
  }
}

/// 弹幕消息
class DanmakuMessage {
  final String id;
  final String roomId;
  final String userId;
  final String userName;
  final String content;
  final int type; // 0: normal, 1: gift, 2: system
  final DateTime timestamp;

  DanmakuMessage({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.userName,
    required this.content,
    this.type = 0,
    required this.timestamp,
  });

  factory DanmakuMessage.fromJson(Map<String, dynamic> json) {
    return DanmakuMessage(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      content: json['content'] as String,
      type: json['type'] as int? ?? 0,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

