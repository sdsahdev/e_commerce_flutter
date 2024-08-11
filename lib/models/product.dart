// product.dart
class Product {
  final String name;
  final double price;
  final String image; // Ensure this field is defined
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  // Method to create a Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
      description: json['description'],
    );
  }
}
