import 'package:trouvetout/app/data/models/product.dart';
import 'package:trouvetout/app/data/providers/base_provider.dart';

class ProductProvider extends BaseProvider {

  Future<List<Product>> retrieve() async {

    return [
      Product(id: 2, name: "name 2", rating: 0, comments: 0, description: "description", price: 500, categories: ["cat"], regularPrice: 1500, images: ['images'])
    ];

    var response = await api.getAsync("products",);

    return Product.fromList(response);

  }

  Future<List<Product>> popular() async {
    return await retrieve();
  }

  Future<List<Product>> newest() async {
    return await retrieve();
  }

}