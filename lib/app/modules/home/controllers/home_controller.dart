import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:retry/retry.dart';
import 'package:trouvetout/app/data/providers/product_provider.dart';

class HomeController extends GetxController {

  final ProductProvider provider = Get.find();
  final Rxn<List<WooProduct>> newest = Rxn<List<WooProduct>>();
  final Rxn<List<WooProduct>> popular = Rxn<List<WooProduct>>();

  @override
  void onReady() {
    super.onReady();
    loadNewest();
    loadPopular();
  }

  Future<void> loadNewest() async {
    newest.value = await retry(() => provider.newest());
  }

  Future<void> loadPopular() async {
    popular.value = await retry(() => provider.popular());
  }

}
