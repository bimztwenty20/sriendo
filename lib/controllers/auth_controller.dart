// File: lib/controllers/auth_controller.dart
import 'package:flutter_application_1/models/user.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _isLoggedIn = false.obs;
  final _user = Rxn<User>();

  bool get isLoggedIn => _isLoggedIn.value;
  User? get user => _user.value;

  Future<void> login(String email, String password) async {
    try {
      // Implementasi login API
      _isLoggedIn.value = true;
      // Set user data
      Get.snackbar('Sukses', 'Login berhasil');
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Login gagal: ${e.toString()}');
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      // Implementasi register API
      Get.snackbar('Sukses', 'Registrasi berhasil');
      Get.toNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Registrasi gagal: ${e.toString()}');
    }
  }

  void logout() {
    _isLoggedIn.value = false;
    _user.value = null;
    Get.offAllNamed('/login');
  }
}