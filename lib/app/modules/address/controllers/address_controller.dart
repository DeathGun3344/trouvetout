import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/customer.dart';
import 'package:get/get.dart';
import 'package:retry/retry.dart';
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
    Billing? address = Get.find<AddressService>().address();
    if(address != null) {
      name.text = address.lastName ?? "";
      phone.text = address.phone ?? "";
      city(address.city);
      this.address.text = address.address1 ?? "";

    }
  }

  Future<void> submit() async {
    if(!form.currentState!.validate()) {
      return;
    }

    final Billing address = Billing(
        city: city()!,
        address1: this.address.text,
        phone: phone.text,
      lastName: name.text
    );

    if(service.isAuth) {
      retry(() => Get.find<UserProvider>().address(billing: address, id: service.id));
      service.user!.billing = address;
    }
    Get.find<AddressService>().address(address);

    Get.back();

  }


}
