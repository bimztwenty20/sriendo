// File: lib/bindings/app_binding.dart
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'package:flutter_application_1/controllers/cart_controller.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(ProductController());
    Get.put(CartController());
  }
}