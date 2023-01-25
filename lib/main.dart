import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trouvetout/app/data/providers/order_provider.dart';
import 'package:trouvetout/app/data/providers/product_provider.dart';
import 'package:trouvetout/app/data/providers/user_provider.dart';
import 'package:trouvetout/app/data/services/address_service.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';
import 'package:trouvetout/app/data/services/cart_service.dart';

import 'app/routes/app_pages.dart';

void main() async {

  await initServices();

  runApp(
    GetMaterialApp(
      title: "TrouveTout",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

Future<void> initServices() async {

  Get.put(OrderProvider());
  Get.put(ProductProvider());
  Get.put(UserProvider());

  Get.put(AddressService());
  Get.put(AuthService());
  Get.put(CartService());

}