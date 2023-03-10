import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_wp_woocommerce/models/customer.dart';

import 'package:get/get.dart';
import 'package:trouvetout/app/core/const/app_colors.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/core/utils/format.dart';
import 'package:trouvetout/app/data/services/address_service.dart';
import 'package:trouvetout/app/data/services/cart_service.dart';
import 'package:trouvetout/app/modules/cart/widgets/item.dart';
import 'package:trouvetout/app/modules/cart/widgets/success.dart';
import 'package:trouvetout/app/routes/app_pages.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  final CartService service = Get.find();
  final Rxn<Billing> address = Get.find<AddressService>().address;
  late final Rx<FlutterCart> cart = service.cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextHeader(title: "Mon panier"),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.1),
                            blurRadius: 4,
                            spreadRadius: 5,
                            offset: const Offset(2, 2),
                          ),
                        ]),
                    child: Obx(() {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                address()?.lastName ?? "Nom & Prenom",
                                style: AppFont.medium.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.ADDRESS);
                                },
                                child: Text(
                                  "Changer",
                                  style: AppFont.regular.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      color: AppColors.primaryColorRed),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            address()?.phone ?? "Num??ro de t??l??phone",
                            style: AppFont.medium.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            address() == null
                                ? "Adresse de livraison"
                                : "${address()!.city} ${address()!.address1}",
                            style: AppFont.regular.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      );
                    })),
                const SizedBox(
                  height: 35,
                ),
                Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    itemCount: cart().getCartItemCount(),
                    itemBuilder: (_, index) {
                      return Item(
                        item: cart().cartItem[index],
                      );
                    },
                  );
                }),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total",
                    style: AppFont.medium.copyWith(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(() {
                    return Text(
                      Format.money(service.total),
                      style: AppFont.semiBold
                          .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                    );
                  })
                ],
              ),
              const Spacer(),
              SizedBox(
                  width: 150,
                  child: Obx(() {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColorYellow,
                          textStyle: AppFont.medium.copyWith(
                              fontSize: 15, fontWeight: FontWeight.normal)),
                      onPressed: cart().cartItem.isEmpty
                          ? null
                          : () {
                              if (address() == null ||
                                  address()!.address1?.isEmpty == true || address()!.phone?.isEmpty == true || address()!.lastName?.isEmpty == true) {
                                Get.toNamed(Routes.ADDRESS);
                                return;
                              }

                              Get.defaultDialog(
                                  title: "Confirmation",
                                  content: const Text(
                                      "Cliquez sur CONFIRMER pour valider votre commande",
                                      textAlign: TextAlign.center),
                                  textCancel: "Continuer les achats",
                                  textConfirm: "Confirmer",
                                  onConfirm: () {
                                    Get.showOverlay(
                                        asyncFunction: () async {
                                          await controller.submit();
                                          if (Get.isDialogOpen == true) {
                                            Get.back();
                                          }
                                          Get.dialog(Success());
                                        },
                                        loadingWidget: const Center(
                                          child: CircularProgressIndicator(),
                                        ));
                                  });
                            },
                      child: const Text('Commander'),
                    );
                  })),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextHeader({required String title}) {
    return Text(
      title,
      style:
          AppFont.semiBold.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
    );
  }
}
