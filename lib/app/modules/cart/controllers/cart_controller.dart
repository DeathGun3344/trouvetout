import 'package:get/get.dart';
import 'package:trouvetout/app/data/services/cart_service.dart';

class CartController extends GetxController {


  Future<void> submit() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.find<CartService>().cart.clear();
  }

}
