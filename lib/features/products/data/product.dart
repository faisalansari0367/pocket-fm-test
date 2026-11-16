class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final title = json['title'];
    final description = json['description'];
    final price = json['price'];
    final imageUrl = json['image'];
    final category = json['category'];
    final ratingJson = json['rating'];

    if (id is! num ||
        title is! String ||
        description is! String ||
        price is! num ||
        imageUrl is! String ||
        category is! String ||
        ratingJson is! Map<String, dynamic>) {
      throw const FormatException(
        'A product contains invalid or missing fields.',
      );
    }

    final rating = ratingJson['rate'];
    final ratingCount = ratingJson['count'];
    if (rating is! num || ratingCount is! num) {
      throw const FormatException('A product rating contains invalid fields.');
    }

    return Product(
      id: id.toInt(),
      title: title,
      description: description,
      price: price.toDouble(),
      imageUrl: imageUrl,
      category: category,
      rating: rating.toDouble(),
      ratingCount: ratingCount.toInt(),
    );
  }

  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int ratingCount;

  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'price': price,
    'image': imageUrl,
    'category': category,
    'rating': {'rate': rating, 'count': ratingCount},
  };
}
