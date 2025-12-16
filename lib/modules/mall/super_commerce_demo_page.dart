import 'package:flutter/material.dart';

/// 超级应用 - 电商 / 商城模块 Demo 聚合
class SuperCommerceDemoPage extends StatelessWidget {
  const SuperCommerceDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('超级电商 / 商城能力'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('基础能力'),
          _FeatureCard(
            title: '商品展示 & 搜索',
            description: '瀑布流首页、分类浏览、搜索筛选（当前以 Mock 列表 + 搜索框展示，可复用到真实商品流）。',
            trailing: const Text('示例：Home 列表'),
          ),
          _FeatureCard(
            title: '商品详情页',
            description: '分段式详情（图文 / 规格 / 评价 / 推荐），可基于现有 UI 组件和路由快速搭建。',
          ),
          _FeatureCard(
            title: '购物流程（购物车 / 订单）',
            description: '加入购物车、多店铺结算、地址管理，可结合本地存储能力做订单草稿与缓存（此处不再跳转旧 Demo 页面）。',
          ),
          _FeatureCard(
            title: '统一支付体系',
            description: '封装支付 Service，支持多种支付方式（微信、支付宝、银行卡、内购等），此处仅做能力说明。',
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('营销与增长'),
          _FeatureCard(
            title: '优惠券 / 积分 / 拼团 / 秒杀',
            description: '统一抽象为「权益」与「活动」模型，支持多种玩法配置和倒计时 UI 模块。',
          ),
          _FeatureCard(
            title: '直播带货',
            description: '直播间能力（连麦、礼物打赏、在线人数等）与视频模块统一规划，这里不再单独打开 Demo 页。',
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('进阶能力'),
          _FeatureCard(
            title: '多店铺系统',
            description: '支持不同商家独立后台，通过多租户字段（tenantId）实现数据隔离。',
          ),
          _FeatureCard(
            title: '本地生活 & 到店核销',
            description: '结合地图与扫码能力做门店地图和核销，这里只说明场景，不再跳转 Demo 页面。',
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

class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget? trailing;
  final Widget? action;

  const _FeatureCard({
    Key? key,
    required this.title,
    required this.description,
    this.trailing,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
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
