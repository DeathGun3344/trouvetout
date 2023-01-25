import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retry/retry.dart';
import 'package:trouvetout/app/data/models/address.dart';
import 'package:trouvetout/app/data/providers/user_provider.dart';
import 'package:trouvetout/app/data/services/address_service.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';

class AddressController extends GetxController {

  final AuthService service = Get.find();

  final GlobalKey<FormState> form = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final RxnString city = RxnString();

  @override
  void onReady() {
    super.onReady();
    load();
  }

  void load() {
    if(!service.isAuth) {
      return;
    }
    name.text = service.user!.name;
  }

  Future<void> submit() async {
    if(!form.currentState!.validate()) {
      return;
    }

    final Address address = Address(
        firstname: "",
        lastname: name.text,
        city: city()!,
        address: this.address.text,
        phone: phone.text
    );

    if(service.isAuth) {
      retry(() => Get.find<UserProvider>().address());
      service.user!.address = address;
    }
    Get.find<AddressService>().address(address);

    Get.back();

  }


}
