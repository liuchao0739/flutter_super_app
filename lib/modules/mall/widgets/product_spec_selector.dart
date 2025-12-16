import 'package:flutter/material.dart';

/// 规格选择器组件
class ProductSpecSelector extends StatelessWidget {
  final String specKey;
  final String specValue;
  final String? selectedValue;
  final Function(String) onSelected;

  const ProductSpecSelector({
    Key? key,
    required this.specKey,
    required this.specValue,
    required this.selectedValue,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 解析规格值（可能是多个选项，用 / 分隔）
    final options = specValue.split('/').map((e) => e.trim()).toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$specKey:',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final isSelected = selectedValue == option;
              return ChoiceChip(
                label: Text(option),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    onSelected(option);
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
