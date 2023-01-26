import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:trouvetout/app/data/providers/base_provider.dart';

class CategoryProvider extends BaseProvider {

  Future<List<WooProductCategory>> retrieve() async {
    return await api.getProductCategories(
      parent: 0,
      hideEmpty: true,
      perPage: 100
    );

  }
}