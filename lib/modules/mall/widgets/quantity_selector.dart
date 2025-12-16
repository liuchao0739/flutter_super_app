import 'package:flutter/material.dart';

/// 数量选择器组件
class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int? max;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onChanged,
    this.min = 1,
    this.max,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '数量',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: quantity > min
              ? () => onChanged(quantity - 1)
              : null,
        ),
        Text(
          '$quantity',
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: max != null && quantity >= max!
              ? null
              : () => onChanged(quantity + 1),
        ),
      ],
    );
  }
}

