import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/data/models/user.dart';
import 'package:trouvetout/app/data/providers/user_provider.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';
import 'package:trouvetout/app/routes/app_pages.dart';

class LoginController extends GetxController {

  final GlobalKey<FormState> form = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final RxBool show = false.obs;

  Future<void> submit() async {
    if(!form.currentState!.validate()) {
      return;
    }
    await Future.delayed(const Duration(seconds: 3));
    User user = await Get.find<UserProvider>().login(email: email.text, password: password.text);
    Get.find<AuthService>().login(user: user);
    next();
  }

  void anonymous() async {
    await Get.find<AuthService>().anonymous();
    next();
  }

  void next() {
    if(Get.previousRoute == "") {
      Get.offAllNamed(Routes.BASE);
    } else {
      Get.back();
    }
  }

}
