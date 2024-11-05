import 'package:flutter_application_1/models/product.dart';

class CartItem {
  final String id;
  final Product product;
  int quantity;
  
  CartItem({
    required this.id,
    required this.product,
    this.quantity = 1,
  });

  double get total => product.price * quantity;

  // Tambahkan fungsi ini jika ingin menambah kuantitas
  void incrementQuantity() {
    quantity++;
  }

  // Tambahkan fungsi ini jika ingin mengurangi kuantitas
  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
