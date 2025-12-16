import 'package:flutter/material.dart';
import '../../../models/task.dart';

/// 文档详情页
class DocumentDetailPage extends StatelessWidget {
  final Document document;

  const DocumentDetailPage({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(document.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: 分享文档
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('TODO(prod): 分享文档')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: 更多操作
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 文档信息
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: document.ownerAvatar != null
                      ? NetworkImage(document.ownerAvatar!)
                      : null,
                  child: document.ownerAvatar == null
                      ? Text(
                          document.ownerName.isNotEmpty
                              ? document.ownerName[0]
                              : '?',
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.ownerName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '更新于 ${_formatTime(document.updateTime)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (document.isShared)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '已分享',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
              ],
            ),
            const Divider(height: 32),
            // 文档内容
            Text(
              document.content ?? '暂无内容',
              style: const TextStyle(fontSize: 14, height: 1.6),
            ),
            const SizedBox(height: 32),
            // 操作按钮
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: 编辑文档
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('TODO(prod): 打开文档编辑器')),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('编辑'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: 协作
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('TODO(prod): 打开协作功能')),
                      );
                    },
                    icon: const Icon(Icons.people),
                    label: const Text('协作'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.year}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

