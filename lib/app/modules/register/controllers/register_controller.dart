import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/data/providers/user_provider.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> form = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> submit() async {
    if (!form.currentState!.validate()) {
      return;
    }

    try {
      final WooCustomer user = await Get.find<UserProvider>().register(
          email: email.text, password: password.text, name: name.text);

      await Get.find<AuthService>().login(user: user);

      Get.back();
    } catch (e) {
      Get.snackbar('Erreur', 'Une erreur est survenue');
    }
  }
}
