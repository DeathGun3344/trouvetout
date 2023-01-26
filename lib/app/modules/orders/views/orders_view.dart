import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:trouvetout/app/core/const/app_colors.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/core/utils/format.dart';
import 'package:trouvetout/app/data/providers/product_provider.dart';
import 'package:trouvetout/app/modules/orders/widget/detail.dart';
import 'package:trouvetout/app/modules/orders/widget/order_image.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black,
                    size: 20,
                  )),
              Text(
                "Mes commandes",
                style: AppFont.bold.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: controller.obx(
                (orders) => ListView.builder(
                  itemCount: orders!.length,
                  itemBuilder: (_, index) {
                    WooOrder order = orders[index];
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                            onTap: () {
                              Get.dialog(Detail(order: order));
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(.1),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      offset: const Offset(2, 2),
                                    ),
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: OrderImage(order: order),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            order.lineItems?.first.name ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppFont.bold.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: "Quantity:",
                                                        style: AppFont.regular
                                                            .copyWith(
                                                          fontSize: 13,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text: order
                                                                .lineItems!
                                                                .length
                                                                .toString(),
                                                            style: AppFont
                                                                .semiBold
                                                                .copyWith(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: "Total: ",
                                                        style: AppFont.regular
                                                            .copyWith(
                                                          fontSize: 13,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text: Format.money(
                                                                int.parse(order
                                                                        .total ??
                                                                    '0')),
                                                            style: AppFont
                                                                .semiBold
                                                                .copyWith(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                Format.date(DateTime.parse(
                                                    order.dateCreated!)),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppFont.regular.copyWith(
                                                  fontSize: 13,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                              Card(
                                                  color: AppColors
                                                      .primaryColorYellow,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                        Format.state(
                                                            order.status),
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )));
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
