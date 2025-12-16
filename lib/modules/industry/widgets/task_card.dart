import 'package:flutter/material.dart';
import '../../../models/task.dart';

/// 任务卡片组件
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskCard({
    Key? key,
    required this.task,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PriorityBadge(priority: task.priority),
                ],
              ),
              if (task.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  task.description!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: task.assigneeAvatar != null
                        ? NetworkImage(task.assigneeAvatar!)
                        : null,
                    child: task.assigneeAvatar == null
                        ? Text(
                            task.assigneeName.isNotEmpty
                                ? task.assigneeName[0]
                                : '?',
                            style: const TextStyle(fontSize: 10),
                          )
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      task.assigneeName,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  if (task.dueTime != null)
                    Text(
                      _formatDueTime(task.dueTime!),
                      style: TextStyle(
                        fontSize: 10,
                        color: _isOverdue(task.dueTime!)
                            ? Colors.red
                            : Colors.grey[600],
                      ),
                    ),
                ],
              ),
              if (task.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  children: task.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue[700],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDueTime(DateTime dueTime) {
    final now = DateTime.now();
    final difference = dueTime.difference(now);

    if (difference.inDays < 0) {
      return '已逾期';
    } else if (difference.inDays == 0) {
      return '今天到期';
    } else if (difference.inDays == 1) {
      return '明天到期';
    } else {
      return '${difference.inDays}天后到期';
    }
  }

  bool _isOverdue(DateTime dueTime) {
    return dueTime.isBefore(DateTime.now());
  }
}

/// 优先级标签组件
class PriorityBadge extends StatelessWidget {
  final String priority;

  const PriorityBadge({Key? key, required this.priority}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (priority) {
      case 'high':
        color = Colors.red;
        text = '高';
        break;
      case 'medium':
        color = Colors.orange;
        text = '中';
        break;
      case 'low':
        color = Colors.grey;
        text = '低';
        break;
      default:
        color = Colors.grey;
        text = priority;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

