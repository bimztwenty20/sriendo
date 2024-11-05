// File: lib/controllers/cart_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // Cari apakah produk dengan ID yang sama sudah ada di keranjang
  final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
  if (existingIndex >= 0) {
    // Jika produk sudah ada di keranjang, tambahkan kuantitasnya
    _items[existingIndex].quantity++;
  } else {
    // Jika produk belum ada di keranjang, tambahkan sebagai item baru
    _items.add(
      CartItem(
        id: product.id, // Gunakan product.id untuk mengidentifikasi item
        product: product,
        quantity: 1,
      ),
    );
  }
    
    // Memperbarui tampilan setelah perubahan
    update();
  }

  // Menghapus item dari keranjang berdasarkan ID produk
  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    update();
  }

  // Memperbarui jumlah item tertentu di keranjang berdasarkan ID produk
  void updateQuantity(String productId, int quantity) {
    if (quantity < 1) return; // Tidak memperbolehkan kuantitas di bawah 1
    
    final index = _items.indexWhere((item) => item.product.id == productId);
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

  // Fungsi untuk mengurangi stok produk di Firestore ketika pembayaran dilakukan
  Future<void> reduceStock() async {
    for (var item in _items) {
      final productRef = FirebaseFirestore.instance.collection('products').doc(item.product.id.toString());

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(productRef);

        if (snapshot.exists) {
          int currentStock = snapshot.get('stock'); // Pastikan mengambil data dengan 'get'
          int newStock = currentStock - item.quantity;

          print('Current stock: $currentStock');
          print('New stock: $newStock');

          transaction.update(productRef, {'stock': newStock});
        } else {
          print('Product not found: ${item.product.id}');
        }
      }).catchError((error) {
        print('Error reducing stock: $error');
      });
    }
    clearCart();
  }
}

