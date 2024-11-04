// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/controllers/product_controller.dart';
// import 'package:flutter_application_1/models/product.dart';
// import 'package:flutter_application_1/screens/product_screen.dart';
// import 'package:get/get.dart';

// class ProductCard extends StatelessWidget {
//   final Product product;
//   final ProductController productController = Get.find();

//   ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         onTap: () => Get.to(() => ProductListScreen(product: product)), // Perbaikan di sini
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(4),
//                     topRight: Radius.circular(4),
//                   ),
//                 ),
//                 child: Center(
//                   child: Image.network(
//                     product.imageUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return const Icon(Icons.image);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Rp ${product.price.toStringAsFixed(0)}',
//                     style: const TextStyle(color: Colors.blue),
//                   ),
//                   const SizedBox(height: 8),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () => productController.addToCart(product),
//                       child: const Text('+ Keranjang'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
