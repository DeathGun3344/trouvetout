
import 'package:logger/logger.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

void main() async {
  WooCommerceAPI api = WooCommerceAPI(
      url: "https://www.trouvetout.net",
      consumerKey: "ck_77cb78d8487932744905b133d18ff849abee5277",
      consumerSecret: "cs_bce2f244968750d2dd6ae9eb2dba38fc47f559e5");

  List orders = await api.getAsync('orders');

  print(orders[0]);
}