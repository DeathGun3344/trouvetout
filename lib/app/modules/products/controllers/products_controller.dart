import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:retry/retry.dart';
import 'package:trouvetout/app/data/providers/product_provider.dart';

class ProductsController extends GetxController with StateMixin<List<WooProduct>> {

  RxnInt category = RxnInt();
  RxBool featured = RxBool(false);
  final TextEditingController search = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    change(null, status: RxStatus.loading());
    try {
      List<WooProduct> products = await retry(() => Get.find<ProductProvider>().retrieve(
          search: search.text,
          category: category(),
          featured: featured()
      ));
      change(products, status: RxStatus.success());
    } catch(e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }


}
