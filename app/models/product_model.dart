class Product {
  final String productId; // Unique identifier for the product
  final String name;
  final String image;
  final double price;
  final bool active; // Added field

  Product({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.active, // Added parameter
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] ?? "",
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      price: json['price']?.toDouble() ?? 0.0,
      active: json['active'] ?? false, // Added field mapping
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      'price': price,
      'active': active, // Added field mapping
    };
  }
}
