
import 'package:get/get.dart';
import 'package:trouvetout/app/data/models/address.dart';
import 'package:trouvetout/app/data/models/cart.dart';
import 'package:trouvetout/app/data/models/product.dart';

class CartService extends GetxService {

  final RxList<Cart> cart = RxList<Cart>();
  int get total {
    int sum = 0;

    cart.forEach((c) {
      sum += (c.quantity * c.product.price);
    });

    return sum;
  }

  Future<void> init() async {
    /*cart.add(Cart(
        product: Product(id: 1, name: "name", rating: 0, comments: 0, description: "description", price: 500, categories: ["cat"], regularPrice: 1500, images: ['images'])
    ));*/
    //TODO: Synchroniser les produits locaux avec ceux en ligne pour eviter qu'ils soient trop obsolete vis a vis des prix
  }

  void toggle({required Product product}) {
    if(check(product: product)) {
      remove(product: product);
    } else {
      add(product: product);
    }
  }

  void add({required Product product}) {
    if(!check(product: product)) {
      cart.add(Cart(product: product));
    }
  }

  void remove({required Product product}) {
    cart.removeWhere((c) => c.product.id == product.id);
  }

  bool check({required Product product}) {
    return cart.indexWhere((c) => c.product.id == product.id) != -1;
  }

  void increase({required int index}) {
    cart[index].quantity++;
    cart.refresh();
  }

  void decrease({required int index}) {
    cart[index].quantity--;
    if(cart[index].quantity <= 0) {
      cart.removeAt(index);
    }
    cart.refresh();
  }

}