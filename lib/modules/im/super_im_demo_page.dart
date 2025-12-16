import 'package:flutter/material.dart';

import '../im/im_demo_page.dart';

/// 超级应用 - IM / 社交模块 Demo 聚合
class SuperImDemoPage extends StatelessWidget {
  const SuperImDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('超级 IM / 社交能力'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('基础通讯'),
          _FeatureRow(
            title: '多类型消息',
            description: '文字、图片、语音、视频、文件、位置统一抽象为 Message 实体，方便扩展与存储。',
          ),
          _FeatureRow(
            title: '会话管理',
            description: '单聊、群聊、会话列表，支持未读数、置顶、免打扰等常见能力。',
            action: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ImDemoPage()),
                );
              },
              child: const Text('查看 IM Demo'),
            ),
          ),
          _FeatureRow(
            title: '音视频通话',
            description: '一对一 / 群组通话、屏幕共享，建议以信令 + 媒体流分层封装，便于替换底层 SDK。',
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('社交能力'),
          _FeatureRow(
            title: '通讯录与关系链',
            description: '好友、群组、关注/粉丝统一通过 Relation 表建模，支持黑名单与推荐联系人。',
          ),
          _FeatureRow(
            title: '动态 / 朋友圈',
            description: '图文动态流，支持点赞、评论、@、话题，UI 模式可参考短视频 / 信息流。',
          ),
          _FeatureRow(
            title: '红包系统',
            description: '普通红包、拼手气红包统一抽象为「红包订单」，带状态流转与防重发放。',
          ),
          _FeatureRow(
            title: '状态与隐私',
            description: '在线状态、个性签名、阅后即焚、消息撤回，配套多端同步与审计策略。',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String title;
  final String description;
  final Widget? action;

  const _FeatureRow({
    Key? key,
    required this.title,
    required this.description,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
            if (action != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: action!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
