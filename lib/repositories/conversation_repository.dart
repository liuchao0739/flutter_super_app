import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/conversation.dart';

/// 会话数据仓库
/// TODO(prod): 替换为真实 IM SDK 调用
class ConversationRepository {
  static List<Conversation>? _cachedConversations;
  static Map<String, List<Message>> _messagesMap = {};

  /// 加载会话列表
  Future<List<Conversation>> loadConversations() async {
    if (_cachedConversations != null) {
      return _cachedConversations!;
    }

    try {
      final String jsonString =
          await rootBundle.loadString('assets/mock/conversations.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedConversations = jsonList
          .map((json) => Conversation.fromJson(json as Map<String, dynamic>))
          .toList();
      // 按置顶和时间排序
      _cachedConversations!.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return a.isPinned ? -1 : 1;
        }
        final aTime = a.lastMessageTime ?? DateTime(1970);
        final bTime = b.lastMessageTime ?? DateTime(1970);
        return bTime.compareTo(aTime);
      });
      return _cachedConversations!;
    } catch (e) {
      return [];
    }
  }

  /// 获取会话消息列表
  Future<List<Message>> loadMessages(String conversationId) async {
    if (_messagesMap.containsKey(conversationId)) {
      return _messagesMap[conversationId]!;
    }

    try {
      final String jsonString =
          await rootBundle.loadString('assets/mock/messages_$conversationId.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      final messages = jsonList
          .map((json) => Message.fromJson(json as Map<String, dynamic>))
          .toList();
      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      _messagesMap[conversationId] = messages;
      return messages;
    } catch (e) {
      // 如果没有对应的消息文件，返回空列表
      return [];
    }
  }

  /// 发送消息
  Future<Message> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderName,
    required int type,
    required String content,
    String? mediaUrl,
  }) async {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversationId,
      senderId: senderId,
      senderName: senderName,
      type: type,
      content: content,
      mediaUrl: mediaUrl,
      timestamp: DateTime.now(),
    );

    if (!_messagesMap.containsKey(conversationId)) {
      _messagesMap[conversationId] = [];
    }
    _messagesMap[conversationId]!.add(message);

    // 更新会话的最后消息
    if (_cachedConversations != null) {
      final index = _cachedConversations!
          .indexWhere((c) => c.id == conversationId);
      if (index != -1) {
        _cachedConversations![index] = _cachedConversations![index].copyWith(
          lastMessage: type == 0 ? content : '[图片]',
          lastMessageType: type,
          lastMessageTime: DateTime.now(),
        );
      }
    }

    return message;
  }

  /// 置顶/取消置顶
  Future<void> togglePin(String conversationId) async {
    if (_cachedConversations != null) {
      final index = _cachedConversations!
          .indexWhere((c) => c.id == conversationId);
      if (index != -1) {
        _cachedConversations![index] =
            _cachedConversations![index].copyWith(
          isPinned: !_cachedConversations![index].isPinned,
        );
        // 重新排序
        _cachedConversations!.sort((a, b) {
          if (a.isPinned != b.isPinned) {
            return a.isPinned ? -1 : 1;
          }
          final aTime = a.lastMessageTime ?? DateTime(1970);
          final bTime = b.lastMessageTime ?? DateTime(1970);
          return bTime.compareTo(aTime);
        });
      }
    }
  }

  /// 标记已读
  Future<void> markAsRead(String conversationId) async {
    if (_cachedConversations != null) {
      final index = _cachedConversations!
          .indexWhere((c) => c.id == conversationId);
      if (index != -1) {
        _cachedConversations![index] =
            _cachedConversations![index].copyWith(unreadCount: 0);
      }
    }
  }

  /// 删除消息
  Future<void> deleteMessage(String conversationId, String messageId) async {
    if (_messagesMap.containsKey(conversationId)) {
      _messagesMap[conversationId]!
          .removeWhere((m) => m.id == messageId);
    }
  }
}

