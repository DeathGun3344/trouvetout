import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';
import 'package:trouvetout/app/routes/app_pages.dart';

class LoginController extends GetxController {

  final GlobalKey<FormState> form = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final RxBool show = false.obs;

  void anonymous() async {
    await Get.find<AuthService>().anonymous();
    if(Get.previousRoute == "") {
      Get.offAllNamed(Routes.BASE);
    } else {
      Get.back();
    }
  }

}
