
class OrderItem {
  final int id;
  final String name;
  final int quantity;
  final int total;
  final String image;

  OrderItem({required this.id, required this.name, required this.quantity, required this.total, required this.image});

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(id: json['id'], image: json['image']['src'], quantity: json['quantity'], name: json['name'], total: int.parse(json['total']));

  static List<OrderItem> fromList(List list) => list.map((e) => OrderItem.fromJson(e)).toList();

}