import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';

import 'package:get/get.dart';
import 'package:trouvetout/app/data/providers/category_provider.dart';
import 'package:trouvetout/app/data/providers/order_provider.dart';
import 'package:trouvetout/app/data/providers/product_provider.dart';
import 'package:trouvetout/app/data/providers/user_provider.dart';
import 'package:trouvetout/app/data/services/address_service.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';
import 'package:trouvetout/app/data/services/cart_service.dart';
import 'package:trouvetout/app/data/services/category_service.dart';

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

  Get.put(WooCommerce(
      baseUrl: "https://www.trouvetout.net",
      consumerKey: "ck_77cb78d8487932744905b133d18ff849abee5277",
      consumerSecret: "cs_bce2f244968750d2dd6ae9eb2dba38fc47f559e5"));

  Get.put(OrderProvider());
  Get.put(ProductProvider());
  Get.put(UserProvider());
  Get.put(CategoryProvider());

  Get.put(AddressService());
  Get.put(AuthService());
  Get.put(CartService());
  Get.put(CategoryService());

}