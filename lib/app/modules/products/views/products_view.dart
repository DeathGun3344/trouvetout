import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trouvetout/app/data/models/product.dart';
import 'package:trouvetout/app/routes/app_pages.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.filter_alt_outlined)
            ),
          ),
          Expanded(child: ListView.separated(
              itemCount: 15,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, __) {
                return ListTile(
                  onTap: () => Get.toNamed(Routes.DETAIL, arguments: Product(id: 1, name: 'name', rating: 0, comments: 0, description: 'description', price: 1500, categories: ['categories'], regularPrice: 1500, images: ['images'])),
                  leading: const SizedBox(
                    width: 50,
                    child: Placeholder(),
                  ),
                  title: const Text('Viceuse - Perceuse'),
                  subtitle: const Text('Equipement'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              }
          ))
        ],
      )
    );
  }
}
