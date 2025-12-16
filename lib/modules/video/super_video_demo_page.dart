import 'package:flutter/material.dart';

/// 超级应用 - 视频 / 短视频 / 直播模块 Demo 聚合
class SuperVideoDemoPage extends StatelessWidget {
  const SuperVideoDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('超级视频 / 直播能力'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('短视频能力'),
          _FeatureRow(
            title: '短视频信息流',
            description: '上下滑动浏览、双击点赞、左右滑动切换，同一套 UI 能支持电商详情、内容分发、直播回放。',
          ),
          _FeatureRow(
            title: '互动功能',
            description:
                '弹幕、评论、收藏、分享、合拍，基于统一的互动事件模型（Like/Comment/Favorite/Share）。',
          ),
          _FeatureRow(
            title: '创作者工具',
            description: '拍摄、剪辑、滤镜、特效、字幕，统一包装为「编辑管线」，方便替换底层 SDK（此处不再跳转旧 Media Demo 页）。',
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('长视频 / 播放器'),
          _FeatureRow(
            title: '播放器内核',
            description: '多清晰度、倍速播放、投屏、后台播放，采用抽象 Player 接口以便接入不同厂商 SDK。',
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('直播系统'),
          _FeatureRow(
            title: '直播互动',
            description: '连麦、礼物打赏、管理员功能，结合 IM 消息通道实现在线人数与实时互动（不再打开旧 Live Demo 页）。',
          ),
          _FeatureRow(
            title: '内容生态',
            description: '关注、推荐、热门榜单，基于统一 Feed 流与推荐策略实现个性化分发。',
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
