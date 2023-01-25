import 'package:get/get.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';
import 'package:trouvetout/app/data/services/cart_service.dart';
import 'package:trouvetout/app/routes/app_pages.dart';

class SplashController extends GetxController {

  final AuthService service = Get.find();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  Future<void> load() async {
    await Future.wait([
      service.auth(),
      Get.find<CartService>().init()
    ]);

    if(service.isAuth || service.isAnonymous) {
      Get.offAndToNamed(Routes.BASE);
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }

  }

}
