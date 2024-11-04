// File: lib/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/cart_controller.dart';
import 'package:flutter_application_1/widget/cart_item_widget.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: Obx(() {
        if (cartController.items.isEmpty) {
          return const Center(
            child: Text('Keranjang belanja kosong'),
          );
        }
        
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.items.length,
                itemBuilder: (context, index) {
                  final item = cartController.items[index];
                  return CartItemWidget(item: item);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}