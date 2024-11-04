import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/cart_controller.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Product> _products = <Product>[].obs;
  final RxBool _isLoading = false.obs;
  final Rx<String?> _error = Rx<String?>(null); // Set _error to nullable

  List<Product> get products => _products.toList();
  bool get isLoading => _isLoading.value;
  String? get error => _error.value;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final querySnapshot = await _firestore
          .collection('products')
          .orderBy('name')
          .get();

      if (querySnapshot.docs.isEmpty) {
        _error.value = 'No products available';
        return;
      }

      final productsList = querySnapshot.docs.map((doc) {
        final data = {
          'id': doc.id,
          ...doc.data(),
        };

        try {
          return Product.fromJson(data);
        } catch (e) {
          print('Error parsing product ${doc.id}: $e');
          return null;
        }
      }).where((product) => product != null).map((product) => product!).toList();

      _products.assignAll(productsList);
    } catch (e) {
      _error.value = 'Failed to fetch products: $e';
      Get.snackbar(
        'Error',
        'Failed to fetch products: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        backgroundColor: Get.theme.errorColor.withOpacity(0.1),
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refreshProducts() => fetchProducts();

 Future<Product?> getProductById(String id) async {
  try {
    final doc = await _firestore.collection('products').doc(id).get();
    if (!doc.exists) return null;

    final data = {
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>, // Cast to Map<String, dynamic>
    };

    return Product.fromJson(data);
  } catch (e) {
    print('Error getting product $id: $e');
    return null;
  }
}


  Map<String, List<Product>> get productsByCategory {
    return _products.fold<Map<String, List<Product>>>(
      {},
      (map, product) {
        final category = product.category;
        final productsInCategory = map[category] ?? [];
        map[category] = [...productsInCategory, product];
        return map;
      },
    );
  }

  void addToCart(Product product) {
    try {
      Get.find<CartController>().addItem(product);
      Get.snackbar(
        'Success',
        '${product.name} added to cart',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add to cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    _products.clear();
    super.onClose();
  }
}

extension on ThemeData {
  Color get errorColor => Colors.red;
}
