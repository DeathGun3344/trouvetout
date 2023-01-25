
import 'package:trouvetout/app/data/models/product.dart';

class Cart {
  int quantity;
  final Product product;

  Cart({required this.product, this.quantity = 1});

}