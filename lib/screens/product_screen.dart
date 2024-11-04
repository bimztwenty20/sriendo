import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart';
import 'cart_screen.dart';

class ProductScreen extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.to(() => CartScreen()),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => productController.fetchProducts(),
        child: Obx(() {
          // Tampilkan loading
          if (productController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Tampilkan error jika ada
          if (productController.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(productController.error!),
                  ElevatedButton(
                    onPressed: () => productController.fetchProducts(),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          final productsByCategory = productController.productsByCategory;

          // Tampilkan pesan jika tidak ada produk
          if (productsByCategory.isEmpty) {
            return const Center(
              child: Text('Tidak ada produk tersedia saat ini.'),
            );
          }

          // Tampilkan list produk
          return ListView.builder(
            itemCount: productsByCategory.length,
            itemBuilder: (context, index) {
              final category = productsByCategory.keys.elementAt(index);
              final products = productsByCategory[category] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Header
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.grey[200],
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Products List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, productIndex) {
                      final product = products[productIndex];
                      return ProductCard(
                        product: product,
                        onAddToCart: () => productController.addToCart(product),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}

// Pindahkan ProductCard ke widget terpisah untuk better organization
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${product.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (product.stock > 0)
                    Text(
                      'Stok: ${product.stock}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            // Add to Cart Button
            IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: product.stock > 0 ? onAddToCart : null,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}