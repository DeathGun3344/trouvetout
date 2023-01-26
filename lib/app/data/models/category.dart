class Category {
  final int id;
  final String name;

  Category(
      {required this.id,
      required this.name,});

  //TODO: Verifier les clés
  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json['id'],
      name: json['name']);

  static List<Category> fromList(List l) => l.map((e) => Category.fromJson(e)).toList().cast<Category>();
}
