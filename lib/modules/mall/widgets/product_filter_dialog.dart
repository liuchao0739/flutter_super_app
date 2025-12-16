import 'package:flutter/material.dart';
import '../state/product_state.dart';

/// 商品筛选对话框
class ProductFilterDialog extends StatefulWidget {
  final ProductListState currentState;
  final Function({
    double? minPrice,
    double? maxPrice,
    String? sortBy,
  }) onFilter;

  const ProductFilterDialog({
    Key? key,
    required this.currentState,
    required this.onFilter,
  }) : super(key: key);

  @override
  State<ProductFilterDialog> createState() => _ProductFilterDialogState();
}

class _ProductFilterDialogState extends State<ProductFilterDialog> {
  late double? minPrice;
  late double? maxPrice;
  late String? sortBy;

  @override
  void initState() {
    super.initState();
    minPrice = widget.currentState.minPrice;
    maxPrice = widget.currentState.maxPrice;
    sortBy = widget.currentState.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('筛选'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 价格筛选
            const Text('价格范围', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '最低价',
                      hintText: minPrice?.toString() ?? '0',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      minPrice = value.isEmpty ? null : double.tryParse(value);
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('-'),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '最高价',
                      hintText: maxPrice?.toString() ?? '不限',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      maxPrice = value.isEmpty ? null : double.tryParse(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 排序
            const Text('排序方式', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<String?>(
              title: const Text('默认'),
              value: null,
              groupValue: sortBy,
              onChanged: (value) {
                setState(() => sortBy = value);
              },
            ),
            RadioListTile<String?>(
              title: const Text('价格从低到高'),
              value: 'price_asc',
              groupValue: sortBy,
              onChanged: (value) {
                setState(() => sortBy = value);
              },
            ),
            RadioListTile<String?>(
              title: const Text('价格从高到低'),
              value: 'price_desc',
              groupValue: sortBy,
              onChanged: (value) {
                setState(() => sortBy = value);
              },
            ),
            RadioListTile<String?>(
              title: const Text('销量最高'),
              value: 'sales_desc',
              groupValue: sortBy,
              onChanged: (value) {
                setState(() => sortBy = value);
              },
            ),
            RadioListTile<String?>(
              title: const Text('评分最高'),
              value: 'rating_desc',
              groupValue: sortBy,
              onChanged: (value) {
                setState(() => sortBy = value);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onFilter(minPrice: null, maxPrice: null, sortBy: null);
            Navigator.pop(context);
          },
          child: const Text('重置'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onFilter(minPrice: minPrice, maxPrice: maxPrice, sortBy: sortBy);
            Navigator.pop(context);
          },
          child: const Text('确定'),
        ),
      ],
    );
  }
}

