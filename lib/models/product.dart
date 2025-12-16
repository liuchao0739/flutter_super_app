/// 商品模型
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> imageUrls;
  final String tenantId; // 多租户支持
  final List<String> tags;
  final String status; // on_sale, sold_out, etc.
  final int salesCount;
  final double rating;
  final int ratingCount;
  final List<ProductSku> skus;
  final Map<String, dynamic>? specs; // 规格信息

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.imageUrls,
    required this.tenantId,
    required this.tags,
    required this.status,
    this.salesCount = 0,
    this.rating = 0.0,
    this.ratingCount = 0,
    required this.skus,
    this.specs,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      imageUrl: json['imageUrl'] as String,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [json['imageUrl'] as String],
      tenantId: json['tenantId'] as String? ?? 'default',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      status: json['status'] as String? ?? 'on_sale',
      salesCount: json['salesCount'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingCount: json['ratingCount'] as int? ?? 0,
      skus: (json['skus'] as List<dynamic>?)
              ?.map((e) => ProductSku.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      specs: json['specs'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'imageUrls': imageUrls,
      'tenantId': tenantId,
      'tags': tags,
      'status': status,
      'salesCount': salesCount,
      'rating': rating,
      'ratingCount': ratingCount,
      'skus': skus.map((e) => e.toJson()).toList(),
      'specs': specs,
    };
  }
}

/// 商品 SKU
class ProductSku {
  final String id;
  final String productId;
  final Map<String, String> specs; // 规格组合，如 {"color": "red", "size": "L"}
  final double price;
  final int stock;
  final String? imageUrl;

  ProductSku({
    required this.id,
    required this.productId,
    required this.specs,
    required this.price,
    required this.stock,
    this.imageUrl,
  });

  factory ProductSku.fromJson(Map<String, dynamic> json) {
    return ProductSku(
      id: json['id'] as String,
      productId: json['productId'] as String,
      specs: Map<String, String>.from(json['specs'] as Map),
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'specs': specs,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
    };
  }
}
