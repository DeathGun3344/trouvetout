import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/core/utils/format.dart';
import 'package:trouvetout/app/data/models/order.dart';
import 'package:trouvetout/app/data/models/order_item.dart';

class Detail extends StatelessWidget {

  final Order order;

  Detail({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 21,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Détails de la commande',
          style: AppFont.semiBold,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Commande No: ${order.number}",
                  style: AppFont.semiBold.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  Format.date(order.createdAt),
                  style: AppFont.regular
                      .copyWith(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${order.items.length} articles',
              style: AppFont.medium.copyWith(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              itemCount: order.items.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              itemBuilder: (_, index) {
                OrderItem item = order.items[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
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
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(item.image),
                                fit: BoxFit.cover
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: AppFont.semiBold.copyWith(
                                      color: Colors.black, fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  'Mango',
                                  style: AppFont.medium.copyWith(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Quantity: ",
                                              style: AppFont.regular.copyWith(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: item.quantity.toString(),
                                                  style:
                                                  AppFont.regular.copyWith(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        Format.money(item.total),
                                        textAlign: TextAlign.right,
                                        style: AppFont.medium.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Informations sur la commande',
              style: AppFont.medium.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            buildOrderInformation(title: "Adresse", description: order.shipping),
            const SizedBox(
              height: 25,
            ),
            buildOrderInformation(title: "Total", description: Format.money(order.total)),

          ],
        ),
      ),
    );
  }

  Widget buildOrderInformation({required String title,required String description}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2 ,
          child: Text(
            '$title:',
            style: AppFont.medium.copyWith(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w400),
          ),
        ),

        Expanded(
          flex: 3,
          child: Text(
            description,
            style: AppFont.medium.copyWith(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

}
