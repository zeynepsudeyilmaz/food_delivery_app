class Food {
  final String id;
  final String name;
  final double price;
  final String category;
  final String image;
  final String? description;

  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    this.description,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      category: json['category'],
      image: json['image'],
      description: json['description'],
    );
  }
}
