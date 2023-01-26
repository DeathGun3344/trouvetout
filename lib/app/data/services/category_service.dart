import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/data/providers/category_provider.dart';

class CategoryService extends GetxService {

  final List<WooProductCategory> categories = [];

  Future<void> init() async {
    categories.addAll(await Get.find<CategoryProvider>().retrieve());
  }

}