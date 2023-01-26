import 'package:get/get.dart';
import 'package:trouvetout/app/modules/cart/controllers/cart_controller.dart';
import 'package:trouvetout/app/modules/home/controllers/home_controller.dart';
import 'package:trouvetout/app/modules/products/controllers/products_controller.dart';

import '../controllers/base_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(
      () => BaseController(),
    );
    Get.put<HomeController>(HomeController());
    Get.lazyPut<ProductsController>(
          () => ProductsController(),
    );
    Get.put<CartController>(CartController(), permanent: true);
  }
}
