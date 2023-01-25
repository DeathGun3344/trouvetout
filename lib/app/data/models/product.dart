class Product {
  final int id;
  final String name;
  final double rating;
  final int comments;
  final List<String> categories;
  final String description;
  final int price;
  final int regularPrice;
  final List<String> images;

  Product(
      {required this.id,
      required this.name,
        required this.rating,
        required this.comments,
      required this.description,
      required this.price,
        required this.categories,
      required this.regularPrice,
      required this.images});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'],
      name: json['name'],
      rating: double.parse(json['average_rating']),
      comments: json['rating_count'],
      description: json['description'],
      price: int.parse(json['price']),
      categories: json['categories'].map((image) => image['name']).toList().cast<String>(),
      regularPrice: int.parse(json['regular_price']),
      images: json['images'].map((image) => image['src']).toList().cast<String>());

  static List<Product> fromList(List l) => l.map((e) => Product.fromJson(e)).toList().cast<Product>();
}
