import 'package:flutter/material.dart';
import 'package:flutter_application_1/bindings/app_binding.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/product_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBvGdYIDRk_6UJhCQfHqPlzAt_mWD_r6YI',
        appId: '1:177448860880:android:162759e48e6f54a704f2d5',
        messagingSenderId: '177448860880',
        projectId: 'sriendo-e05f4',
        storageBucket: 'sriendo-e05f4.firebasestorage.app',
      ),
    );
    print("Firebase initialized successfully");
    
    // Initialize controllers
    Get.put(ProductController());
    
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sriendo Telekom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: AppBinding(),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => const MainScreen()),
        GetPage(name: '/cart', page: () => CartScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
      ],
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const Scaffold(
          body: Center(child: Text('Halaman tidak ditemukan')),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ProductScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}