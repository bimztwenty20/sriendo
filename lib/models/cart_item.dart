// File: lib/models/cart_item.dart
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
}









