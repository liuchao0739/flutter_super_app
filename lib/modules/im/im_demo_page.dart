import 'package:flutter/material.dart';

/// 即时通讯 / 通知 Demo：
/// - Mock 系统通知推送
/// - 简单的单聊窗口（本地消息列表）
class ImDemoPage extends StatefulWidget {
  const ImDemoPage({Key? key}) : super(key: key);

  @override
  State<ImDemoPage> createState() => _ImDemoPageState();
}

class _ImDemoPageState extends State<ImDemoPage> {
  final List<_ChatMessage> _messages = [
    _ChatMessage(fromMe: false, content: '欢迎使用 IM Demo，这里是系统小助手～'),
  ];
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mock: 收到一条系统通知')),
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(fromMe: true, content: text));
      _messages.add(_ChatMessage(fromMe: false, content: '（Mock 回复）已收到：$text'));
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IM / 通知 Demo'),
        actions: [
          IconButton(
            onPressed: _sendNotification,
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment:
                      msg.fromMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: msg.fromMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg.content,
                      style: TextStyle(
                        color: msg.fromMe ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '输入消息...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final bool fromMe;
  final String content;

  _ChatMessage({required this.fromMe, required this.content});
}


