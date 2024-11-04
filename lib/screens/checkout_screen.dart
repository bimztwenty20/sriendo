// File: lib/screens/checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  final CartController cartController = Get.find();
  final AuthController authController = Get.find();

  CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Alamat Pengiriman
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Alamat Pengiriman',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(authController.user?.address ?? ''),
                      TextButton(
                        onPressed: () {
                          // Implementasi ubah alamat
                        },
                        child: const Text('Ubah Alamat'),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Ringkasan Pesanan
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ringkasan Pesanan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...cartController.items.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${item.product.name} (${item.quantity}x)'),
                            Text('Rp ${item.total.toStringAsFixed(0)}'),
                          ],
                        ),
                      )),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rp ${cartController.total.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Tombol Bayar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implementasi proses pembayaran
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Konfirmasi Pembayaran'),
                        content: const Text('Lanjutkan ke pembayaran?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Proses pembayaran
                              Get.back();
                              cartController.clearCart();
                              Get.offAllNamed('/home');
                              Get.snackbar(
                                'Sukses',
                                'Pesanan berhasil dibuat',
                              );
                            },
                            child: const Text('Bayar'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Bayar Sekarang'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}