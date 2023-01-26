
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/core/utils/format.dart';
import 'package:trouvetout/app/data/providers/product_provider.dart';

class OrderImage extends StatelessWidget {

  final WooOrder order;

  OrderImage({required this.order});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WooProduct>(
      future: Get.find<ProductProvider>()
          .find(id: order.lineItems!.first.productId!),
      builder: (_, data) {
        if(!data.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
                image:
                CachedNetworkImageProvider(Format.image(data.data?.images.first.src)),
                fit: BoxFit.cover),
            borderRadius:
            const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft:
                Radius.circular(8)),
          ),
        );
      },
    );
  }
}
