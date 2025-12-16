import 'package:flutter/material.dart';

/// 超级应用 - 行业扩展能力设计总览
///
/// 这里更多是“架构蓝图 + 能力规划”，方便后续按需落地成具体模块。
class SuperIndustryDemoPage extends StatelessWidget {
  const SuperIndustryDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('行业扩展能力蓝图'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _IndustrySection(
            title: '办公协作',
            features: [
              '文档协作：在线文档 / 表格 / 幻灯片，多人实时编辑，评论与修订记录。',
              '任务管理：待办、项目看板、甘特图、日历集成。',
              '云存储：个人 / 团队网盘，权限与空间配额管理。',
            ],
          ),
          _IndustrySection(
            title: '生活服务 / 本地生活',
            features: [
              '外卖 / 打车 / 到店服务：统一订单与履约模型。',
              '票务预约：日历与场次管理，支持退改签规则。',
              '商家平台：多角色多权限控制台。',
            ],
          ),
          _IndustrySection(
            title: '金融与教育',
            features: [
              '金融服务：理财、保险、借贷，需合规与风控能力（这里只做架构留位，实际接入需持牌资质）。',
              '教育服务：在线课程、作业提交、考试系统，支持班级 / 学校多层组织结构。',
            ],
          ),
          _IndustrySection(
            title: '娱乐与内容',
            features: [
              '小游戏平台：H5 与原生小游戏统一接入规范，支持内购与虚拟道具。',
              '阅读系统：小说 / 漫画 / 新闻 Feed，支持书架与阅读进度同步。',
              '音乐平台：歌单、播放列表、多端同步播放记录。',
            ],
          ),
        ],
      ),
    );
  }
}

class _IndustrySection extends StatelessWidget {
  final String title;
  final List<String> features;

  const _IndustrySection({
    Key? key,
    required this.title,
    required this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...features.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(
                      child: Text(
                        f,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


