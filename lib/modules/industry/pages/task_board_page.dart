import 'package:flutter/material.dart';
import '../../../models/task.dart';
import '../widgets/task_column.dart';

/// 任务看板页
class TaskBoardPage extends StatefulWidget {
  const TaskBoardPage({Key? key}) : super(key: key);

  @override
  State<TaskBoardPage> createState() => _TaskBoardPageState();
}

class _TaskBoardPageState extends State<TaskBoardPage> {
  final List<Task> _tasks = [
    Task(
      id: 'task_001',
      title: '完成 Flutter 超级应用开发',
      description: '实现所有 Tab 的功能模块',
      status: 'in_progress',
      priority: 'high',
      assigneeId: 'user_001',
      assigneeName: '张三',
      createTime: DateTime.now().subtract(const Duration(days: 2)),
      dueTime: DateTime.now().add(const Duration(days: 5)),
      tags: ['开发', 'Flutter'],
    ),
    Task(
      id: 'task_002',
      title: '设计 UI 界面',
      description: '完成所有页面的 UI 设计',
      status: 'todo',
      priority: 'medium',
      assigneeId: 'user_002',
      assigneeName: '李四',
      createTime: DateTime.now().subtract(const Duration(days: 1)),
      dueTime: DateTime.now().add(const Duration(days: 3)),
      tags: ['设计', 'UI'],
    ),
    Task(
      id: 'task_003',
      title: '编写技术文档',
      description: '整理项目架构和技术文档',
      status: 'done',
      priority: 'low',
      assigneeId: 'user_003',
      assigneeName: '王五',
      createTime: DateTime.now().subtract(const Duration(days: 5)),
      tags: ['文档'],
    ),
    Task(
      id: 'task_004',
      title: '代码审查',
      description: '审查所有代码并修复问题',
      status: 'todo',
      priority: 'high',
      assigneeId: 'user_001',
      assigneeName: '张三',
      createTime: DateTime.now().subtract(const Duration(hours: 12)),
      dueTime: DateTime.now().add(const Duration(days: 2)),
      tags: ['审查', '代码'],
    ),
  ];

  List<Task> get _todoTasks =>
      _tasks.where((t) => t.status == 'todo').toList();
  List<Task> get _inProgressTasks =>
      _tasks.where((t) => t.status == 'in_progress').toList();
  List<Task> get _doneTasks =>
      _tasks.where((t) => t.status == 'done').toList();

  void _updateTaskStatus(String taskId, String newStatus) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == taskId);
      if (index != -1) {
        _tasks[index] = _tasks[index].copyWith(status: newStatus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('任务看板'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: 添加新任务
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('TODO: 添加新任务')),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: TaskColumn(
              title: '待办',
              tasks: _todoTasks,
              color: Colors.blue,
              onTaskTap: (task) {
                _updateTaskStatus(task.id, 'in_progress');
              },
            ),
          ),
          Expanded(
            child: TaskColumn(
              title: '进行中',
              tasks: _inProgressTasks,
              color: Colors.orange,
              onTaskTap: (task) {
                _updateTaskStatus(task.id, 'done');
              },
            ),
          ),
          Expanded(
            child: TaskColumn(
              title: '已完成',
              tasks: _doneTasks,
              color: Colors.green,
              onTaskTap: null,
            ),
          ),
        ],
      ),
    );
  }
}

