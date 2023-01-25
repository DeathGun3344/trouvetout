import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';
import 'package:trouvetout/app/routes/app_pages.dart';

class BaseController extends GetxController {

  final AuthService authService = Get.find();
  int prev = 0;
  late final RxInt index = 0.obs..listen((i) {
    if(i == 3 && !authService.isAuth) {
      index(prev);
      Get.toNamed(Routes.LOGIN);
      return;
    }
    prev = i;
    page.animateToPage(i, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  });
  final PageController page = PageController();

}
