import 'package:flutter/material.dart';
import 'pages/product_list_page.dart';

/// 超级应用 - 电商 / 商城模块
/// 直接显示商品列表页
class SuperCommerceDemoPage extends StatelessWidget {
  const SuperCommerceDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProductListPage();
  }
}
