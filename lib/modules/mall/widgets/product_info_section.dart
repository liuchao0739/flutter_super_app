import 'package:flutter/material.dart';
import '../../../models/product.dart';

/// 商品信息部分组件
class ProductInfoSection extends StatelessWidget {
  final Product product;
  final double? currentPrice;

  const ProductInfoSection({
    Key? key,
    required this.product,
    this.currentPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 价格
        Row(
          children: [
            Text(
              '¥${(currentPrice ?? product.price).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            if (product.originalPrice != null) ...[
              const SizedBox(width: 12),
              Text(
                '¥${product.originalPrice!.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        // 商品名称
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // 评分和销量
        Row(
          children: [
            Icon(Icons.star, size: 18, color: Colors.amber[700]),
            const SizedBox(width: 4),
            Text(
              '${product.rating}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 16),
            Text(
              '已售${product.salesCount}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

