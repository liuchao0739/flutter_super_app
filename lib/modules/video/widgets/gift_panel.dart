import 'package:flutter/material.dart';

/// 礼物面板组件
class GiftPanel extends StatelessWidget {
  final Function(String) onGiftSelected;

  const GiftPanel({
    Key? key,
    required this.onGiftSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gifts = [
      {'name': '玫瑰', 'icon': Icons.local_florist, 'color': Colors.red},
      {'name': '爱心', 'icon': Icons.favorite, 'color': Colors.pink},
      {'name': '钻石', 'icon': Icons.diamond, 'color': Colors.blue},
      {'name': '火箭', 'icon': Icons.rocket_launch, 'color': Colors.orange},
    ];

    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: gifts.map((gift) {
          return GestureDetector(
            onTap: () => onGiftSelected(gift['name'] as String),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: (gift['color'] as Color).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    gift['icon'] as IconData,
                    color: gift['color'] as Color,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  gift['name'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

