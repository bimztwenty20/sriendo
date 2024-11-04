import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;

  final List<Map<String, dynamic>> _providers = [
    {
      'name': 'Axis',
      'icon': Icons.network_cell,
      'color': Colors.deepPurple,
    },
    {
      'name': 'Indosat',
      'icon': Icons.wifi,
      'color': const Color.fromARGB(255, 255, 230, 7),
    },
    {
      'name': 'Smartfren',
      'icon': Icons.signal_cellular_alt,
      'color': const Color.fromARGB(255, 236, 2, 100),
    },
    {
      'name': 'Simpati',
      'icon': Icons.phone_android,
      'color': Colors.red,
    },
    {
      'name': 'Three',
      'icon': Icons.sim_card,
      'color': Colors.orange,
    },
    {
      'name': 'XL',
      'icon': Icons.sim_card,
      'color': const Color.fromARGB(255, 0, 34, 255),
    },
  ];

  final List<String> bannerImages = [
    'assets/images/Axis1.png',
    'assets/images/tribaner1.png',
    'assets/images/tselbaner1.jpeg',
    'assets/images/isatbaner1.jpeg',
  ];

  @override
  void initState() {
    super.initState();

    // Timer untuk otomatis slide
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      int nextPage = _pageController.page!.toInt() + 1;
      if (nextPage >= bannerImages.length) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> productImages = [
      'assets/images/smart1.jpg',
      'assets/images/axis1.jpeg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SRIENDO TELEKOM',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implementasi pencarian
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Implementasi notifikasi
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Slider with PageView and Indicator
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: bannerImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(bannerImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            SmoothPageIndicator(
              controller: _pageController,
              count: bannerImages.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.blue,
                dotColor: Colors.grey,
              ),
            ),

            // Kategori
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kategori Voucher Internet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _providers.length,
                      itemBuilder: (context, index) {
                        final provider = _providers[index];
                        return Container(
                          width: 80,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: provider['color'],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                provider['icon'],
                                color: Colors.white,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                provider['name'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Produk Populer
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Produk Populer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: productImages.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(productImages[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Produk ${index + 1}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text('Rp 100.000'),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Implementasi tambah ke keranjang
                                    },
                                    child: const Text('+ Keranjang'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
