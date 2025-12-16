import 'package:flutter/material.dart';
import 'pages/task_board_page.dart';
import 'pages/document_list_page.dart';

/// 超级应用 - 行业蓝图 / 垂直场景
class SuperIndustryDemoPage extends StatefulWidget {
  const SuperIndustryDemoPage({Key? key}) : super(key: key);

  @override
  State<SuperIndustryDemoPage> createState() => _SuperIndustryDemoPageState();
}

class _SuperIndustryDemoPageState extends State<SuperIndustryDemoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('行业'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '任务看板'),
            Tab(text: '文档'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TaskBoardPage(),
          DocumentListPage(),
        ],
      ),
    );
  }
}
