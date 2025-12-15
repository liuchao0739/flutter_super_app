import 'package:flutter/material.dart';

class PaymentService {
  static Future<bool> pay(String method, double amount) async {
    // Mock 支付流程
    await Future.delayed(const Duration(seconds: 2));
    
    // 模拟支付成功
    final success = true;
    
    if (success) {
      debugPrint('支付成功: $method, 金额: ¥$amount');
      return true;
    } else {
      debugPrint('支付失败: $method, 金额: ¥$amount');
      return false;
    }
  }

  static Future<void> showPaymentDialog(BuildContext context, String method, double amount) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('确认支付'),
        content: Text('支付方式: $method\n支付金额: ¥$amount'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('确认'),
          ),
        ],
      ),
    );

    if (result == true) {
      final success = await pay(method, amount);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(success ? '支付成功！' : '支付失败！')),
        );
      }
    }
  }
}

