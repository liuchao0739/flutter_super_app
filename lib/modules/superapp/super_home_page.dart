import 'package:flutter/material.dart';

import '../mall/super_commerce_demo_page.dart';
import '../im/super_im_demo_page.dart';
import '../video/super_video_demo_page.dart';
import '../tools/super_tools_demo_page.dart';
import '../industry/super_industry_demo_page.dart';

/// 超级应用平台首页
///
/// 五个 Tab：电商、IM、视频、工具、行业蓝图。
class SuperHomePage extends StatefulWidget {
  const SuperHomePage({Key? key}) : super(key: key);

  @override
  State<SuperHomePage> createState() => _SuperHomePageState();
}

class _SuperHomePageState extends State<SuperHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          _SuperCommerceTab(),
          _SuperImTab(),
          _SuperVideoTab(),
          _SuperToolsTab(),
          _SuperIndustryTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: '电商',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'IM',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video_outlined),
            label: '视频',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.extension_outlined),
            label: '工具',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.domain_outlined),
            label: '行业',
          ),
        ],
      ),
    );
  }
}

class _SuperCommerceTab extends StatelessWidget {
  const _SuperCommerceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SuperCommerceDemoPage();
  }
}

class _SuperImTab extends StatelessWidget {
  const _SuperImTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SuperImDemoPage();
  }
}

class _SuperVideoTab extends StatelessWidget {
  const _SuperVideoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SuperVideoDemoPage();
  }
}

class _SuperToolsTab extends StatelessWidget {
  const _SuperToolsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SuperToolsDemoPage();
  }
}

class _SuperIndustryTab extends StatelessWidget {
  const _SuperIndustryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SuperIndustryDemoPage();
  }
}
