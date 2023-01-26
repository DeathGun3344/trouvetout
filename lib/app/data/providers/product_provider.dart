import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:logger/logger.dart';
import 'package:trouvetout/app/data/models/product.dart';
import 'package:trouvetout/app/data/providers/base_provider.dart';

class ProductProvider extends BaseProvider {

  final String base = "products?status=publish&type=simple&on_sale=true&stock_status=instock";

  Future<List<Product>> retrieve() async {

    var response = await api.getAsync(base);

    return Product.fromList(response);

  }

  Future<List<Product>> popular() async {

    WooCommerce api = WooCommerce(
        baseUrl: "https://www.trouvetout.net",
        consumerKey: "ck_77cb78d8487932744905b133d18ff849abee5277",
        consumerSecret: "cs_bce2f244968750d2dd6ae9eb2dba38fc47f559e5");

    List<WooProduct> products = await api2.getProducts();

    var response = await api.getAsync("$base&per_page=10&orderby=popularity");

    return Product.fromList(response);
  }

  Future<List<Product>> newest() async {

    var response = await api.getAsync("$base&per_page=10&orderby=date");

    return Product.fromList(response);
  }

}