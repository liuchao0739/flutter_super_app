import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/cart.dart';
import '../../../repositories/cart_repository.dart';
import '../widgets/order_info_row.dart';
import '../widgets/order_status_header.dart';
import '../widgets/order_action_buttons.dart';

/// 订单状态管理
class OrderNotifier extends StateNotifier<Order?> {
  final CartRepository _repository = CartRepository();

  OrderNotifier(String orderId) : super(null) {
    loadOrder(orderId);
  }

  Future<void> loadOrder(String orderId) async {
    final order = await _repository.getOrderById(orderId);
    state = order;
  }

  Future<void> updateStatus(String status) async {
    if (state == null) return;
    await _repository.updateOrderStatus(state!.id, status);
    await loadOrder(state!.id);
  }
}

final orderProvider =
    StateNotifierProvider.family<OrderNotifier, Order?, String>((ref, orderId) {
  return OrderNotifier(orderId);
});

/// 订单详情页
class OrderPage extends ConsumerWidget {
  final String orderId;

  const OrderPage({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider(orderId));
    final notifier = ref.read(orderProvider(orderId).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('订单详情'),
      ),
      body: order == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 订单状态
                  OrderStatusHeader(order: order),
                  // 订单信息
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '订单信息',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        OrderInfoRow(label: '订单号', value: order.id),
                        OrderInfoRow(
                          label: '下单时间',
                          value: _formatDateTime(order.createTime),
                        ),
                        if (order.payTime != null)
                          OrderInfoRow(
                            label: '支付时间',
                            value: _formatDateTime(order.payTime!),
                          ),
                        if (order.shipTime != null)
                          OrderInfoRow(
                            label: '发货时间',
                            value: _formatDateTime(order.shipTime!),
                          ),
                        if (order.completeTime != null)
                          OrderInfoRow(
                            label: '完成时间',
                            value: _formatDateTime(order.completeTime!),
                          ),
                        const Divider(height: 32),
                        // 收货信息
                        if (order.shippingAddress != null) ...[
                          const Text(
                            '收货信息',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          OrderInfoRow(
                            label: '收货人',
                            value: order.receiverName ?? '',
                          ),
                          OrderInfoRow(
                            label: '联系电话',
                            value: order.receiverPhone ?? '',
                          ),
                          OrderInfoRow(
                            label: '收货地址',
                            value: order.shippingAddress ?? '',
                          ),
                          const Divider(height: 32),
                        ],
                        // 商品列表
                        const Text(
                          '商品列表',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...order.items.map((item) => Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item.productImage,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.image_not_supported),
                                      );
                                    },
                                  ),
                                ),
                                title: Text(item.productName),
                                subtitle: Text(
                                  '${item.selectedSpecs.values.join(' / ')} x ${item.quantity}',
                                ),
                                trailing: Text(
                                  '¥${item.totalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[700],
                                  ),
                                ),
                              ),
                            )),
                        const Divider(height: 32),
                        // 价格明细
                        const Text(
                          '价格明细',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        OrderInfoRow(
                          label: '商品总额',
                          value: '¥${order.totalAmount.toStringAsFixed(2)}',
                        ),
                        if (order.discountAmount != null && order.discountAmount! > 0)
                          OrderInfoRow(
                            label: '优惠金额',
                            value: '-¥${order.discountAmount!.toStringAsFixed(2)}',
                            valueColor: Colors.green,
                          ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '实付金额',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '¥${order.finalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // 操作按钮
                  OrderActionButtons(
                    order: order,
                    onPay: () async {
                      // TODO(prod): 调用支付 SDK
                      await notifier.updateStatus('paid');
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('已调用支付 SDK（Mock）')),
                        );
                      }
                    },
                    onCancel: () async {
                      await notifier.updateStatus('cancelled');
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('订单已取消')),
                        );
                      }
                    },
                    onConfirm: () async {
                      await notifier.updateStatus('completed');
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('订单已完成')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

