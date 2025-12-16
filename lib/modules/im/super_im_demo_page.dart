import 'package:flutter/material.dart';
import 'pages/conversation_list_page.dart';

/// 超级应用 - IM / 社交模块
/// 直接显示会话列表页
class SuperImDemoPage extends StatelessWidget {
  const SuperImDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ConversationListPage();
  }
}
