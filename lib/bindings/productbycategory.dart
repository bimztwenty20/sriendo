// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/product_controller.dart';

// class ProductListScreen extends StatelessWidget {
//   final ProductController productController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Produk Internet'),
//       ),
//       body: Obx(() {
//         if (productController.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final productsByCategory = productController.productsByCategory;

//         if (productsByCategory.isEmpty) {
//           return const Center(child: Text('Tidak ada produk tersedia.'));
//         }

//         return ListView(
//           padding: const EdgeInsets.all(16),
//           children: productsByCategory.entries.map((entry) {
//             final category = entry.key;
//             final products = entry.value;

//             return ExpansionTile(
//               title: Text(
//                 category,
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               children: products.map((product) {
//                 return ListTile(
//                   leading: Image.network(
//                     product.imageUrl,
//                     width: 50,
//                     height: 50,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text(product.name),
//                   subtitle: Text('Harga: Rp ${product.price}'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.add_shopping_cart),
//                     onPressed: () {
//                       productController.addToCart(product);
//                     },
//                   ),
//                 );
//               }).toList(),
//             );
//           }).toList(),
//         );
//       }),
//     );
//   }
// }
