import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:trouvetout/app/core/const/app_colors.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/core/utils/format.dart';

class Cart extends StatelessWidget {
  final WooProduct product;

  Cart({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [

              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: Format.image(product.images.first.src),
                    fit: BoxFit.cover,
                    width: 160,
                    height: 220,
                  ),
                ),
              ),
            ],
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
            height: 5,
          ),
          Text(product.categories.first.name ?? "",style: AppFont.regular.copyWith(
        fontSize: 13,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),),
          const SizedBox(
            height: 8,
          ),
          Text(
            product.name ?? "",
            style: AppFont.bold.copyWith(
                fontSize: 17,
                overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            Format.money(int.parse(product.price ?? '0')),
            style: AppFont.bold
                .copyWith(fontSize: 14, color: AppColors.primaryColorRed),
          ),
        ],
      ),
    );
  }
}
