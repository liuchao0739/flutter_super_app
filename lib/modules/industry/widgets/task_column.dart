import 'package:flutter/material.dart';
import '../../../models/task.dart';
import 'task_card.dart';

/// 任务列组件
class TaskColumn extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final Color color;
  final Function(Task)? onTaskTap;

  const TaskColumn({
    Key? key,
    required this.title,
    required this.tasks,
    required this.color,
    this.onTaskTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              '$title (${tasks.length})',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskCard(
                  task: task,
                  onTap: onTaskTap != null ? () => onTaskTap!(task) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

