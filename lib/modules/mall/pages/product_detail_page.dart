import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/product_state.dart';
import '../widgets/product_spec_selector.dart';
import '../widgets/product_info_section.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/product_detail_bottom_bar.dart';
import '../../../models/product.dart';
import '../../../models/cart.dart';
import '../../../repositories/cart_repository.dart';
import 'cart_page.dart';

/// 商品详情页
class ProductDetailPage extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  final PageController _imagePageController = PageController();
  Map<String, String> _selectedSpecs = {};
  ProductSku? _selectedSku;
  int _quantity = 1;

  @override
  void dispose() {
    _imagePageController.dispose();
    super.dispose();
  }

  void _onSpecSelected(String specKey, String specValue) {
    setState(() {
      _selectedSpecs[specKey] = specValue;
      _updateSelectedSku();
    });
  }

  void _updateSelectedSku() {
    final productAsync = ref.read(productProvider(widget.productId));
    final product = productAsync.value;
    if (product == null) return;

    _selectedSku = product.skus.firstWhere(
      (sku) {
        if (sku.specs.length != _selectedSpecs.length) return false;
        return sku.specs.entries.every(
          (entry) => _selectedSpecs[entry.key] == entry.value,
        );
      },
      orElse: () => product.skus.first,
    );
  }

  Future<void> _addToCart() async {
    final productAsync = ref.read(productProvider(widget.productId));
    final product = productAsync.value;
    if (product == null) return;

    if (_selectedSku == null) {
      _updateSelectedSku();
    }

    final cartRepo = CartRepository();
    await cartRepo.init();

    final cartItem = CartItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      productId: product.id,
      productName: product.name,
      productImage: product.imageUrl,
      skuId: _selectedSku!.id,
      selectedSpecs: _selectedSpecs,
      price: _selectedSku!.price,
      quantity: _quantity,
      tenantId: product.tenantId,
    );

    await cartRepo.addToCart(cartItem);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已添加到购物车')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productProvider(widget.productId));

    return Scaffold(
      body: productAsync.when(
        data: (product) {
          if (product == null) {
            return const Center(child: Text('商品不存在'));
          }

          if (_selectedSku == null) {
            _updateSelectedSku();
          }

          return CustomScrollView(
            slivers: [
              // AppBar with images
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: PageView.builder(
                    controller: _imagePageController,
                    itemCount: product.imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        product.imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          );
                        },
                      );
                    },
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              // Product info
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductInfoSection(
                        product: product,
                        currentPrice: _selectedSku?.price,
                      ),
                      const Divider(height: 32),
                      // 规格选择
                      if (product.specs != null && product.specs!.isNotEmpty) ...[
                        const Text(
                          '选择规格',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...product.specs!.entries.map((entry) {
                          return ProductSpecSelector(
                            specKey: entry.key,
                            specValue: entry.value,
                            selectedValue: _selectedSpecs[entry.key],
                            onSelected: (value) => _onSpecSelected(entry.key, value),
                          );
                        }),
                        const SizedBox(height: 16),
                      ],
                      // 数量选择
                      QuantitySelector(
                        quantity: _quantity,
                        onChanged: (newQuantity) {
                          setState(() => _quantity = newQuantity);
                        },
                      ),
                      const Divider(height: 32),
                      // 商品描述
                      const Text(
                        '商品详情',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 100), // 为底部按钮留空间
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('加载失败: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(productProvider(widget.productId));
                  },
                  child: const Text('重试'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ProductDetailBottomBar(
        onAddToCart: _addToCart,
        onBuyNow: () {
          // TODO(prod): 调用支付 SDK
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('已调用支付 SDK（Mock）')),
          );
        },
      ),
    );
  }
}

