import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trouvetout/app/core/const/app_colors.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/core/utils/format.dart';
import 'package:trouvetout/app/data/models/product.dart';

class Cart extends StatelessWidget {
  final Product product;

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
                    imageUrl: product.images.first,
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
                itemCount: product.rating.ceil(),
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
              if(product.comments > 0)
                Text('(${product.comments})')
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(product.categories.first,style: AppFont.regular.copyWith(
        fontSize: 13,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),),
          const SizedBox(
            height: 8,
          ),
          Text(
            product.name,
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
            Format.money(product.price),
            style: AppFont.bold
                .copyWith(fontSize: 14, color: AppColors.primaryColorRed),
          ),
        ],
      ),
    );
  }
}
