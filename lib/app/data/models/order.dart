
import 'order_item.dart';

class Order {
  final int id;
  final int total;
  final String number;
  final DateTime createdAt;
  final String shipping;
  final List<OrderItem> items;
  final String status;
  String get state {
    switch(status) {
      case "pending":
      case "on-hold":
        return "En attente";
      case "processing":
        return "En cours";
      case "completed":
        return "Terminée";
      case "cancelled":
        return "Annulée";
      case "refunded":
        return "Remboursée";
      case "failed":
        return "Echouée";
      case "trash":
        return "Brouillon";
      default:
        return status;
    }
  }
  int get quantity => items.map((e) => e.quantity).reduce((e1, e2) => e1 + e2);

  Order({required this.id, required this.shipping, required this.number, required this.total, required this.status, required this.createdAt, required this.items});

  factory Order.fromJson(Map<String, dynamic> json) => Order(id: json['id'], shipping: json['shipping']['address_1'], number: json['number'], status: json['status'], items: OrderItem.fromList(json['line_items']), createdAt: DateTime.parse(json['date_created_gmt']), total: int.parse(json['total']));

  static List<Order> fromList(List list) => list.map((e) => Order.fromJson(e)).toList();

}