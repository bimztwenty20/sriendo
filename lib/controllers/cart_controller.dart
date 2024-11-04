// File: lib/controllers/cart_controller.dart
import 'package:flutter_application_1/models/cart_item.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _items = <CartItem>[].obs;
  
  // Mendapatkan daftar item di keranjang
  List<CartItem> get items => _items;

  // Mendapatkan total harga semua item di keranjang
  double get total => _items.fold(0, (sum, item) => sum + item.total);

  // Mendapatkan jumlah total jenis item di keranjang
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  // Menambahkan produk ke keranjang
  void addItem(Product product) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      // Jika produk sudah ada di keranjang, tambahkan kuantitasnya
      _items[existingIndex].quantity++;
    } else {
      // Jika produk belum ada di keranjang, tambahkan sebagai item baru
      _items.add(
        CartItem(
          id: DateTime.now().toString(),
          product: product,
        ),
      );
    }
    
    // Menampilkan snackbar notifikasi
    Get.snackbar(
      'Berhasil',
      'Produk ditambahkan ke keranjang',
      duration: const Duration(seconds: 2),
    );
    
    // Memperbarui tampilan setelah perubahan
    update();
  }

  // Menghapus item dari keranjang berdasarkan ID
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    update();
  }

  // Memperbarui jumlah item tertentu di keranjang
  void updateQuantity(String id, int quantity) {
    if (quantity < 1) return; // Tidak memperbolehkan kuantitas di bawah 1
    
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index].quantity = quantity;
      update();
    }
  }

  // Membersihkan seluruh isi keranjang
  void clearCart() {
    _items.clear();
    update();
  }
}
