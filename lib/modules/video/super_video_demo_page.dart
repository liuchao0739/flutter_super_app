import 'package:flutter/material.dart';
import 'pages/video_feed_page.dart';
import 'pages/live_list_page.dart';

/// 超级应用 - 视频 / 短视频 / 直播模块
class SuperVideoDemoPage extends StatefulWidget {
  const SuperVideoDemoPage({Key? key}) : super(key: key);

  @override
  State<SuperVideoDemoPage> createState() => _SuperVideoDemoPageState();
}

class _SuperVideoDemoPageState extends State<SuperVideoDemoPage>
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
        title: const Text('视频'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '推荐'),
            Tab(text: '直播'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          VideoFeedPage(),
          LiveListPage(),
        ],
      ),
    );
  }
}
