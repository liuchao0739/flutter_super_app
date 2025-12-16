import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/conversation.dart';
import '../../../repositories/conversation_repository.dart';

/// 会话列表状态
class ConversationListState {
  final List<Conversation> conversations;
  final bool isLoading;
  final String? error;

  ConversationListState({
    this.conversations = const [],
    this.isLoading = false,
    this.error,
  });

  ConversationListState copyWith({
    List<Conversation>? conversations,
    bool? isLoading,
    String? error,
  }) {
    return ConversationListState(
      conversations: conversations ?? this.conversations,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 会话列表状态管理
class ConversationListNotifier extends StateNotifier<ConversationListState> {
  final ConversationRepository _repository = ConversationRepository();

  ConversationListNotifier() : super(ConversationListState()) {
    loadConversations();
  }

  Future<void> loadConversations() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final conversations = await _repository.loadConversations();
      state = state.copyWith(
        conversations: conversations,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> togglePin(String conversationId) async {
    await _repository.togglePin(conversationId);
    await loadConversations();
  }

  Future<void> markAsRead(String conversationId) async {
    await _repository.markAsRead(conversationId);
    await loadConversations();
  }
}

final conversationListProvider =
    StateNotifierProvider<ConversationListNotifier, ConversationListState>(
        (ref) {
  return ConversationListNotifier();
});

/// 消息列表状态
class MessageListState {
  final List<Message> messages;
  final bool isLoading;
  final String? error;

  MessageListState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  MessageListState copyWith({
    List<Message>? messages,
    bool? isLoading,
    String? error,
  }) {
    return MessageListState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 消息列表状态管理
class MessageListNotifier extends StateNotifier<MessageListState> {
  final ConversationRepository _repository = ConversationRepository();
  final String conversationId;

  MessageListNotifier(this.conversationId) : super(MessageListState()) {
    loadMessages();
  }

  Future<void> loadMessages() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final messages = await _repository.loadMessages(conversationId);
      state = state.copyWith(
        messages: messages,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> sendMessage({
    required String senderId,
    required String senderName,
    required int type,
    required String content,
    String? mediaUrl,
  }) async {
    await _repository.sendMessage(
      conversationId: conversationId,
      senderId: senderId,
      senderName: senderName,
      type: type,
      content: content,
      mediaUrl: mediaUrl,
    );
    await loadMessages();
  }

  Future<void> deleteMessage(String messageId) async {
    await _repository.deleteMessage(conversationId, messageId);
    await loadMessages();
  }
}

final messageListProvider = StateNotifierProvider.family<
    MessageListNotifier, MessageListState, String>((ref, conversationId) {
  return MessageListNotifier(conversationId);
});

