// File: lib/widgets/cart_item_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/cart_controller.dart';
import 'package:flutter_application_1/models/cart_item.dart';
import 'package:get/get.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final CartController cartController = Get.find();

  CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                item.product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp ${item.product.price.toStringAsFixed(0)}',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    cartController.updateQuantity(item.id, item.quantity - 1);
                  },
                ),
                Text('${item.quantity}'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    cartController.updateQuantity(item.id, item.quantity + 1);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    cartController.removeItem(item.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}