import 'package:get/get.dart';
import 'package:retry/retry.dart';
import 'package:trouvetout/app/data/models/order.dart';
import 'package:trouvetout/app/data/providers/order_provider.dart';

class OrdersController extends GetxController with StateMixin<List<Order>> {

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {

    change(null, status: RxStatus.loading());

    List<Order> orders = await retry(() => Get.find<OrderProvider>().retrieve());

    change(orders, status: RxStatus.success());

  }

}
