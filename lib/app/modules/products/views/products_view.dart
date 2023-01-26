import 'package:cached_network_image/cached_network_image.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';

import 'package:get/get.dart';
import 'package:trouvetout/app/core/utils/format.dart';
import 'package:trouvetout/app/data/services/category_service.dart';
import 'package:trouvetout/app/routes/app_pages.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.focusScope?.unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Liste des produits'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size(Get.width, 30),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: controller.search,
                onFieldSubmitted: (_) => controller.load(),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                      onPressed: controller.load,
                    )
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Obx(() {
                    return Checkbox(
                        value: controller.featured(),
                        onChanged: (bool? check) {
                          if(check != null) {
                            controller.featured.value = check;
                            controller.load();
                          }
                        }
                    );
                  }),
                  const Text('Mis en avant'),
                  const Spacer(),
                  Obx(() {
                    return DropdownButton<int?>(
                        value: controller.category(),
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('Toutes les catégories'),
                          ),
                          ...Get.find<CategoryService>().categories.map(
                                  (e) => DropdownMenuItem(
                                value: e.id,
                                child: Text(e.name ?? ""),
                              )
                          ).toList()
                        ],
                        onChanged: (int? category) {
                          controller.category.value = category;
                          controller.load();
                        }
                    );
                  })
                ],
              ),
            ),
            Expanded(child: controller.obx((products) => RefreshIndicator(
              onRefresh: controller.load,
              child: ListView.separated(
                  itemCount: products!.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, i) {
                    final WooProduct product = products[i];
                    return ListTile(
                      onTap: () => Get.toNamed(Routes.DETAIL, arguments: product),
                      leading: CachedNetworkImage(
                        imageUrl: Format.image(product.images.first.src),
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name ?? ""),
                      subtitle: Text(product.categories.first.name ?? ""),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    );
                  }
              ),
            )))
          ],
        )
      ),
    );
  }
}
