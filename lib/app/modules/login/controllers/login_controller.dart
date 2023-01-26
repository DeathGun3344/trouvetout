import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
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

    try {
      WooCustomer user = await Get.find<UserProvider>().login(email: email.text, password: password.text);
      await Get.find<AuthService>().login(user: user);
      next();
    } catch(e) {
     Get.snackbar(
         'Erreur',
         'Identifiant incorrect'
     );
    }
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
