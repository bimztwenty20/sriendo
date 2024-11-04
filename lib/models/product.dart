class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.stock,
  });

  // Metode untuk mengonversi data Firestore menjadi objek Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      stock: json['stock'] as int,
    );
  }
}
