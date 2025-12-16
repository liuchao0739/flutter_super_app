import 'package:flutter/material.dart';

/// 弹幕输入栏组件
class DanmakuInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final Function(String) onGiftSelected;

  const DanmakuInputBar({
    Key? key,
    required this.controller,
    required this.onSend,
    required this.onGiftSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 礼物按钮
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GiftButton(
                          name: '玫瑰',
                          emoji: '🌹',
                          onTap: () => onGiftSelected('玫瑰'),
                        ),
                        const SizedBox(width: 8),
                        GiftButton(
                          name: '爱心',
                          emoji: '❤️',
                          onTap: () => onGiftSelected('爱心'),
                        ),
                        const SizedBox(width: 8),
                        GiftButton(
                          name: '火箭',
                          emoji: '🚀',
                          onTap: () => onGiftSelected('火箭'),
                        ),
                        const SizedBox(width: 8),
                        GiftButton(
                          name: '钻石',
                          emoji: '💎',
                          onTap: () => onGiftSelected('钻石'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 弹幕输入
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: '说点什么...',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onSubmitted: (_) => onSend(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: onSend,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 礼物按钮组件
class GiftButton extends StatelessWidget {
  final String name;
  final String emoji;
  final VoidCallback onTap;

  const GiftButton({
    Key? key,
    required this.name,
    required this.emoji,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 4),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

