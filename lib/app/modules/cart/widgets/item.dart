import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/core/utils/format.dart';
import 'package:trouvetout/app/data/services/cart_service.dart';

class Item extends StatelessWidget {
  final CartService service = Get.find();
  final CartItem item;

  Item({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(item.productDetails['image']),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: AppFont.semiBold.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.withOpacity(.1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  service.increment(product: item.productId);
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                            ),
                            Text(item.quantity.toString()),
                            Expanded(child: InkWell(
                              onTap: (){
                                service.decrement(product: item.productId);
                              },
                              child: const Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),)
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(Format.money(item.subTotal.toInt()))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
