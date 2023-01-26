

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/data/models/product.dart';
import 'package:trouvetout/app/modules/home/controllers/home_controller.dart';
import 'package:trouvetout/app/modules/home/widgets/cart.dart';
import 'package:trouvetout/app/routes/app_pages.dart';

class Body extends GetView<HomeController> {


  @override
  Widget build(BuildContext context) {
    double cardWidth = ((MediaQuery.of(context).size.width - 40) / 2);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeaderBody(title: "Top 10", description: "Meilleurs Ventes"),

          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: cardWidth / 0.59,
            child: Obx(() {
              if(controller.popular() == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount:  controller.popular()!.length,
                padding: const EdgeInsets.all(0.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_,index){
                  Product product = controller.popular()![index];
                  return InkWell(
                    onTap: (){
                      Get.toNamed(Routes.DETAIL, arguments: product);
                    },
                    child: Cart(
                      product: product,
                    ),
                  );
                },
              );
            })
          ),
          const SizedBox(
            height: 30,
          ),
          buildHeaderBody(title: "Nouveaux", description: "Recement ajouté"),

          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: cardWidth / 0.59,
              child: Obx(() {
                if(controller.newest() == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount:  controller.newest()!.length,
                  padding: const EdgeInsets.all(0.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_,index){
                    Product product = controller.newest()![index];
                    return InkWell(
                      onTap: (){
                        Get.toNamed(Routes.DETAIL, arguments: product);
                      },
                      child: Cart(
                        product: product,

                      ),
                    );
                  },
                );
              })
          ),
        ],
      ),
    );
  }

  Widget buildHeaderBody({required String title,required String description}){
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,style: AppFont.bold.copyWith(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(
              height: 8,
            ),
            Text(description,style: AppFont.regular.copyWith(
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),),
          ],
        ),

      ],
    );
  }
}
