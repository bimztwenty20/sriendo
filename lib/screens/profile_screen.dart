import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        final user = authController.user;
        if (user == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Silahkan login terlebih dahulu',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/login'); // Arahkan ke halaman login
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(user.email),
                    const SizedBox(height: 8),
                    Text('Telepon: ${user.phone}'),
                    Text(
                      'Status Akun: ${user.isVerified ? "Terverifikasi" : "Belum Terverifikasi"}',
                      style: TextStyle(
                        color: user.isVerified ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit Profil'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/edit-profile'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text('Alamat Pengiriman'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/address'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.shopping_bag),
                    title: const Text('Riwayat Pesanan'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/order-history'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Bantuan'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Get.toNamed('/help'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: SwitchListTile(
                title: const Text('Mode Gelap'),
                secondary: const Icon(Icons.dark_mode),
                value: Get.isDarkMode,
                onChanged: (value) {
                  Get.changeThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showLogoutDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      }),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              authController.logout();
              Get.offAllNamed('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
