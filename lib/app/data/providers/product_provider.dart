import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:trouvetout/app/data/providers/base_provider.dart';

class ProductProvider extends BaseProvider {

  Future<WooProduct> find({required int id}) async {
    return await api.getProductById(id: id);
  }

  Future<List<WooProduct>> retrieve({int page = 1, String? search, int? category, bool featured = false}) async {
    return await api.getProducts(
      perPage: 100,
      page: page,
      search: search?.isNotEmpty == true ? '$search' : null,
      category: category != null ? '$category' : null,
      featured: featured
    );
  }

  Future<List<WooProduct>> popular() async {

    return await api.getProducts(
      status: 'publish',
      type: 'simple',
      onSale: true,
      stockStatus: 'instock',

      perPage: 10,
      orderBy: 'popularity',
    );
  }

  Future<List<WooProduct>> newest() async {
    return await api.getProducts(
      status: 'publish',
      type: 'simple',
      onSale: true,
      stockStatus: 'instock',

      perPage: 10,
      orderBy: 'date',
    );
  }

}