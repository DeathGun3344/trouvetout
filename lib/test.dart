
import 'package:flutter_wp_woocommerce/woocommerce.dart';

void main() async {
  WooCommerce api = WooCommerce(
      baseUrl: "https://www.trouvetout.net",
      consumerKey: "ck_77cb78d8487932744905b133d18ff849abee5277",
      consumerSecret: "cs_bce2f244968750d2dd6ae9eb2dba38fc47f559e5");

  List<WooProduct> products = await api.getProducts();

  print(products[0]);
}