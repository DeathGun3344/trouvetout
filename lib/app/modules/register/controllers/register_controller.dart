import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/data/models/user.dart';
import 'package:trouvetout/app/data/providers/user_provider.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';

class RegisterController extends GetxController {

  final GlobalKey<FormState> form = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> submit() async {

    if(!form.currentState!.validate()) {
      return;
    }

    await Future.delayed(const Duration(seconds: 2));

    final User user = await Get.find<UserProvider>().register(email: email.text, password: password.text, name: name.text);

    Get.find<AuthService>().login(user: user);

    Get.back();
  }


}
