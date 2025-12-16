/// 购物车项模型
class CartItem {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final String skuId;
  final Map<String, String> selectedSpecs;
  final double price;
  final int quantity;
  final bool isSelected;
  final String tenantId;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.skuId,
    required this.selectedSpecs,
    required this.price,
    this.quantity = 1,
    this.isSelected = true,
    required this.tenantId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      skuId: json['skuId'] as String,
      selectedSpecs: Map<String, String>.from(json['selectedSpecs'] as Map),
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int? ?? 1,
      isSelected: json['isSelected'] as bool? ?? true,
      tenantId: json['tenantId'] as String? ?? 'default',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'skuId': skuId,
      'selectedSpecs': selectedSpecs,
      'price': price,
      'quantity': quantity,
      'isSelected': isSelected,
      'tenantId': tenantId,
    };
  }

  CartItem copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productImage,
    String? skuId,
    Map<String, String>? selectedSpecs,
    double? price,
    int? quantity,
    bool? isSelected,
    String? tenantId,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      skuId: skuId ?? this.skuId,
      selectedSpecs: selectedSpecs ?? this.selectedSpecs,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
      tenantId: tenantId ?? this.tenantId,
    );
  }

  double get totalPrice => price * quantity;
}

/// 订单模型
class Order {
  final String id;
  final String status; // pending_payment, paid, shipped, completed, cancelled
  final List<CartItem> items;
  final double totalAmount;
  final double? discountAmount;
  final double finalAmount;
  final String? shippingAddress;
  final String? receiverName;
  final String? receiverPhone;
  final DateTime createTime;
  final DateTime? payTime;
  final DateTime? shipTime;
  final DateTime? completeTime;
  final String tenantId;

  Order({
    required this.id,
    required this.status,
    required this.items,
    required this.totalAmount,
    this.discountAmount,
    required this.finalAmount,
    this.shippingAddress,
    this.receiverName,
    this.receiverPhone,
    required this.createTime,
    this.payTime,
    this.shipTime,
    this.completeTime,
    required this.tenantId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      status: json['status'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      discountAmount: json['discountAmount'] != null
          ? (json['discountAmount'] as num).toDouble()
          : null,
      finalAmount: (json['finalAmount'] as num).toDouble(),
      shippingAddress: json['shippingAddress'] as String?,
      receiverName: json['receiverName'] as String?,
      receiverPhone: json['receiverPhone'] as String?,
      createTime: DateTime.parse(json['createTime'] as String),
      payTime: json['payTime'] != null
          ? DateTime.parse(json['payTime'] as String)
          : null,
      shipTime: json['shipTime'] != null
          ? DateTime.parse(json['shipTime'] as String)
          : null,
      completeTime: json['completeTime'] != null
          ? DateTime.parse(json['completeTime'] as String)
          : null,
      tenantId: json['tenantId'] as String? ?? 'default',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'items': items.map((e) => e.toJson()).toList(),
      'totalAmount': totalAmount,
      'discountAmount': discountAmount,
      'finalAmount': finalAmount,
      'shippingAddress': shippingAddress,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'createTime': createTime.toIso8601String(),
      'payTime': payTime?.toIso8601String(),
      'shipTime': shipTime?.toIso8601String(),
      'completeTime': completeTime?.toIso8601String(),
      'tenantId': tenantId,
    };
  }

  Order copyWith({
    String? id,
    String? status,
    List<CartItem>? items,
    double? totalAmount,
    double? discountAmount,
    double? finalAmount,
    String? shippingAddress,
    String? receiverName,
    String? receiverPhone,
    DateTime? createTime,
    DateTime? payTime,
    DateTime? shipTime,
    DateTime? completeTime,
    String? tenantId,
  }) {
    return Order(
      id: id ?? this.id,
      status: status ?? this.status,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      finalAmount: finalAmount ?? this.finalAmount,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      createTime: createTime ?? this.createTime,
      payTime: payTime ?? this.payTime,
      shipTime: shipTime ?? this.shipTime,
      completeTime: completeTime ?? this.completeTime,
      tenantId: tenantId ?? this.tenantId,
    );
  }
}

