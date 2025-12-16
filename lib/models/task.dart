/// 任务模型
class Task {
  final String id;
  final String title;
  final String? description;
  final String status; // todo, in_progress, done
  final String priority; // low, medium, high
  final String assigneeId;
  final String assigneeName;
  final String? assigneeAvatar;
  final DateTime createTime;
  final DateTime? dueTime;
  final List<String> tags;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.priority,
    required this.assigneeId,
    required this.assigneeName,
    this.assigneeAvatar,
    required this.createTime,
    this.dueTime,
    required this.tags,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String,
      priority: json['priority'] as String,
      assigneeId: json['assigneeId'] as String,
      assigneeName: json['assigneeName'] as String,
      assigneeAvatar: json['assigneeAvatar'] as String?,
      createTime: DateTime.parse(json['createTime'] as String),
      dueTime: json['dueTime'] != null
          ? DateTime.parse(json['dueTime'] as String)
          : null,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
      'assigneeId': assigneeId,
      'assigneeName': assigneeName,
      'assigneeAvatar': assigneeAvatar,
      'createTime': createTime.toIso8601String(),
      'dueTime': dueTime?.toIso8601String(),
      'tags': tags,
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    String? priority,
    String? assigneeId,
    String? assigneeName,
    String? assigneeAvatar,
    DateTime? createTime,
    DateTime? dueTime,
    List<String>? tags,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assigneeId: assigneeId ?? this.assigneeId,
      assigneeName: assigneeName ?? this.assigneeName,
      assigneeAvatar: assigneeAvatar ?? this.assigneeAvatar,
      createTime: createTime ?? this.createTime,
      dueTime: dueTime ?? this.dueTime,
      tags: tags ?? this.tags,
    );
  }
}

/// 文档模型
class Document {
  final String id;
  final String title;
  final String? content;
  final String type; // doc, sheet, slide
  final String ownerId;
  final String ownerName;
  final String? ownerAvatar;
  final DateTime updateTime;
  final bool isShared;
  final int viewCount;

  Document({
    required this.id,
    required this.title,
    this.content,
    required this.type,
    required this.ownerId,
    required this.ownerName,
    this.ownerAvatar,
    required this.updateTime,
    this.isShared = false,
    this.viewCount = 0,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      type: json['type'] as String,
      ownerId: json['ownerId'] as String,
      ownerName: json['ownerName'] as String,
      ownerAvatar: json['ownerAvatar'] as String?,
      updateTime: DateTime.parse(json['updateTime'] as String),
      isShared: json['isShared'] as bool? ?? false,
      viewCount: json['viewCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'type': type,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'ownerAvatar': ownerAvatar,
      'updateTime': updateTime.toIso8601String(),
      'isShared': isShared,
      'viewCount': viewCount,
    };
  }
}

