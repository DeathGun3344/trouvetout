import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:trouvetout/app/core/const/app_colors.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/core/utils/format.dart';
import 'package:trouvetout/app/data/services/cart_service.dart';
import 'package:trouvetout/app/modules/base/controllers/base_controller.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {

  final WooProduct product = Get.arguments;
  final CartService service = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          product.name ?? "",
          style: AppFont.semiBold,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
                Get.find<BaseController>().index(2);
              },
              icon: Badge(
                badgeStyle: const BadgeStyle(
                  badgeColor: AppColors.primaryColorYellow,
                ),
                badgeContent: Obx(() {
                  return Text("${service.cart().getCartItemCount()}", style: AppFont.regular.copyWith(
                      fontSize: 12,
                      color: Colors.white
                  ),);
                }),
                position: BadgePosition.topEnd(top: -8,end: -5),
                child: const Icon(Icons.shopping_cart_outlined,color: Colors.black,),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 330,
                viewportFraction: 1.0,
                autoPlay: true,
                enlargeCenterPage: false,
                // autoPlay: false,
              ),
              items: product.images
                  .map((e) => CachedNetworkImage(
                fit: BoxFit.cover, imageUrl: Format.image(e.src),
              ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name ?? "",
                          style: AppFont.bold.copyWith(fontSize: 23),
                        ),
                      ),
                      Text(
                        Format.money(int.parse(product.price ?? "0")),
                        style: AppFont.bold.copyWith(fontSize: 23),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    product.categories.first.name ?? "",
                    style: AppFont.regular.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: 5,
                        direction: Axis.horizontal,
                        itemSize: 15,
                        itemCount: double.parse(product.averageRating ?? '0').ceil(),
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {

                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if((product.ratingCount ?? 0) > 0)
                        Text('(${product.ratingCount})')
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  HtmlWidget(
                    product.description ?? "",
                    textStyle: AppFont.regular.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.4,
                        letterSpacing: .2,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (BuildContext ctx) {
          return Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: const Offset(2, -2),
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColorYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                onPressed: () {
                  Get.showOverlay(
                      asyncFunction: () async {
                        try {
                          final bool check = service.check(product: product);
                          if(check) {
                            service.remove(product: product);
                          } else {
                            service.add(product: product);
                          }
                        } catch(e) {
                          Logger().e(e);
                          Get.snackbar('Erreur', 'Une erreur est survenue');
                        }
                      },
                    loadingWidget: const Center(child: CircularProgressIndicator(),)
                  );
                },
                child: Obx(() {
                  final bool check = service.check(product: product);
                  return Text(
                      (check ? 'Retirer du panier' : 'Ajouter au panier').toUpperCase(),
                    style: AppFont.medium
                        .copyWith(fontSize: 17, color: Colors.white),
                  );
                })
              ),
            ),
          );
        },
      ),
    );
  }


}
