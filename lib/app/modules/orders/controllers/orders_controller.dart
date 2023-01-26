import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:retry/retry.dart';
import 'package:trouvetout/app/data/providers/order_provider.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';

class OrdersController extends GetxController with StateMixin<List<WooOrder>> {

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {

    change(null, status: RxStatus.loading());

    List<WooOrder> orders = await retry(() => Get.find<OrderProvider>().retrieve(
      id: Get.find<AuthService>().id
    ));

    change(orders, status: RxStatus.success());

  }

}
