import 'package:flutter/material.dart';
import '../../../models/cart.dart';

/// 订单操作按钮组件
class OrderActionButtons extends StatelessWidget {
  final Order order;
  final VoidCallback? onPay;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  const OrderActionButtons({
    Key? key,
    required this.order,
    this.onPay,
    this.onCancel,
    this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (order.status == 'pending' || order.status == 'pending_payment') ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: onCancel,
                  child: const Text('取消订单'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: onPay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('立即支付'),
                ),
              ),
            ] else if (order.status == 'delivered' || order.status == 'shipped') ...[
              Expanded(
                child: ElevatedButton(
                  onPressed: onConfirm,
                  child: const Text('确认收货'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

