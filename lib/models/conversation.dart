/// 会话模型
class Conversation {
  final String id;
  final String type; // single, group
  final String title;
  final String? avatarUrl;
  final String? lastMessage;
  final int lastMessageType; // 0: text, 1: image, 2: video, etc.
  final int unreadCount;
  final DateTime? lastMessageTime;
  final bool isPinned;
  final bool isMuted;
  final Map<String, dynamic>? extra;

  Conversation({
    required this.id,
    required this.type,
    required this.title,
    this.avatarUrl,
    this.lastMessage,
    this.lastMessageType = 0,
    this.unreadCount = 0,
    this.lastMessageTime,
    this.isPinned = false,
    this.isMuted = false,
    this.extra,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      lastMessage: json['lastMessage'] as String?,
      lastMessageType: json['lastMessageType'] as int? ?? 0,
      unreadCount: json['unreadCount'] as int? ?? 0,
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.parse(json['lastMessageTime'] as String)
          : null,
      isPinned: json['isPinned'] as bool? ?? false,
      isMuted: json['isMuted'] as bool? ?? false,
      extra: json['extra'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'avatarUrl': avatarUrl,
      'lastMessage': lastMessage,
      'lastMessageType': lastMessageType,
      'unreadCount': unreadCount,
      'lastMessageTime': lastMessageTime?.toIso8601String(),
      'isPinned': isPinned,
      'isMuted': isMuted,
      'extra': extra,
    };
  }

  Conversation copyWith({
    String? id,
    String? type,
    String? title,
    String? avatarUrl,
    String? lastMessage,
    int? lastMessageType,
    int? unreadCount,
    DateTime? lastMessageTime,
    bool? isPinned,
    bool? isMuted,
    Map<String, dynamic>? extra,
  }) {
    return Conversation(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      unreadCount: unreadCount ?? this.unreadCount,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
      extra: extra ?? this.extra,
    );
  }
}

/// 消息模型
class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String? senderAvatar;
  final int type; // 0: text, 1: image, 2: video, 3: file, etc.
  final String content;
  final String? mediaUrl;
  final DateTime timestamp;
  final bool isRead;
  final Map<String, dynamic>? extra;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    this.senderAvatar,
    required this.type,
    required this.content,
    this.mediaUrl,
    required this.timestamp,
    this.isRead = false,
    this.extra,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      senderAvatar: json['senderAvatar'] as String?,
      type: json['type'] as int? ?? 0,
      content: json['content'] as String,
      mediaUrl: json['mediaUrl'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool? ?? false,
      extra: json['extra'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversationId': conversationId,
      'senderId': senderId,
      'senderName': senderName,
      'senderAvatar': senderAvatar,
      'type': type,
      'content': content,
      'mediaUrl': mediaUrl,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'extra': extra,
    };
  }
}

