import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/conversation_state.dart';
import 'chat_page.dart';
import '../../../models/conversation.dart';

/// 会话列表页
class ConversationListPage extends ConsumerWidget {
  const ConversationListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(conversationListProvider);
    final notifier = ref.read(conversationListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('消息'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 搜索会话
            },
          ),
        ],
      ),
      body: state.isLoading && state.conversations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.error != null && state.conversations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('加载失败: ${state.error}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => notifier.loadConversations(),
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                )
              : state.conversations.isEmpty
                  ? const Center(child: Text('暂无会话'))
                  : RefreshIndicator(
                      onRefresh: () => notifier.loadConversations(),
                      child: ListView.builder(
                        itemCount: state.conversations.length,
                        itemBuilder: (context, index) {
                          final conversation = state.conversations[index];
                          return _ConversationItem(
                            conversation: conversation,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    conversationId: conversation.id,
                                    conversationTitle: conversation.title,
                                  ),
                                ),
                              );
                            },
                            onLongPress: () {
                              _showConversationMenu(
                                context,
                                conversation,
                                notifier,
                              );
                            },
                          );
                        },
                      ),
                    ),
    );
  }

  void _showConversationMenu(
    BuildContext context,
    Conversation conversation,
    ConversationListNotifier notifier,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                conversation.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
              ),
              title: Text(conversation.isPinned ? '取消置顶' : '置顶'),
              onTap: () {
                notifier.togglePin(conversation.id);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.done_all),
              title: const Text('标记已读'),
              onTap: () {
                notifier.markAsRead(conversation.id);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('删除会话'),
              onTap: () {
                Navigator.pop(context);
                // TODO: 实现删除会话
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 会话项
class _ConversationItem extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _ConversationItem({
    required this.conversation,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // 头像
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: conversation.avatarUrl != null
                      ? NetworkImage(conversation.avatarUrl!)
                      : null,
                  child: conversation.avatarUrl == null
                      ? Text(
                          conversation.title.isNotEmpty
                              ? conversation.title[0]
                              : '?',
                          style: const TextStyle(fontSize: 20),
                        )
                      : null,
                ),
                if (conversation.unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        conversation.unreadCount > 99
                            ? '99+'
                            : '${conversation.unreadCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // 会话信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation.isPinned)
                        Icon(
                          Icons.push_pin,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      const SizedBox(width: 8),
                      Text(
                        _formatTime(conversation.lastMessageTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getLastMessageText(conversation),
                          style: TextStyle(
                            fontSize: 14,
                            color: conversation.unreadCount > 0
                                ? Colors.black87
                                : Colors.grey[600],
                            fontWeight: conversation.unreadCount > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation.isMuted)
                        Icon(
                          Icons.volume_off,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLastMessageText(Conversation conversation) {
    if (conversation.lastMessage == null) {
      return '';
    }
    switch (conversation.lastMessageType) {
      case 1:
        return '[图片]';
      case 2:
        return '[视频]';
      case 3:
        return '[文件]';
      default:
        return conversation.lastMessage!;
    }
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return '昨天';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${time.month}/${time.day}';
    }
  }
}

