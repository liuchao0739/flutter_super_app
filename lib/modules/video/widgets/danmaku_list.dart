import 'package:flutter/material.dart';
import '../../../models/feed_video.dart';

/// 弹幕列表组件
class DanmakuList extends StatelessWidget {
  final List<DanmakuMessage> messages;
  final ScrollController scrollController;

  const DanmakuList({
    Key? key,
    required this.messages,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return DanmakuItem(message: message);
      },
    );
  }
}

/// 弹幕消息项组件
class DanmakuItem extends StatelessWidget {
  final DanmakuMessage message;

  const DanmakuItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isGift = message.type == 1;
    final isSystem = message.type == 2;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSystem
            ? Colors.black.withOpacity(0.5)
            : Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          if (!isSystem) ...[
            CircleAvatar(
              radius: 12,
              child: Text(
                message.userName.isNotEmpty ? message.userName[0] : '?',
                style: const TextStyle(fontSize: 10),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  if (!isSystem && !isGift)
                    TextSpan(
                      text: '${message.userName}: ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  TextSpan(
                    text: isGift
                        ? '${message.userName} 送出了 ${message.content}'
                        : message.content,
                    style: TextStyle(
                      color: isGift ? Colors.yellow : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

