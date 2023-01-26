import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:trouvetout/app/core/utils/format.dart';
import 'package:trouvetout/app/data/providers/product_provider.dart';

class CartService extends GetxService {
  bool _isReady = false;
  int get total => cart().getTotalAmount().toInt();

  late final Rx<FlutterCart> cart = FlutterCart().obs
    ..listen((c) async {
      if(!_isReady) {
        return;
      }
      await GetStorage().remove("cart");
      List<Map<String, int>> cart = [];

      for (CartItem i in c.cartItem) {
        cart.add({'id': i.productId, 'quantity': i.quantity});
      }

      await GetStorage().write("cart", cart);
    });
  final ProductProvider provider = Get.find();

  Future<void> init() async {
    List? cart = GetStorage().read("cart");
    if (cart != null) {
      await Future.wait(cart.map((c) async {
        try {
          WooProduct product = await provider.find(id: c['id']!);
          update(product: product, quantity: c['quantity']!);
        } catch (e) {
          Logger().e(e);
        }
      }).toList());
      _isReady = true;
      this.cart.refresh();
    }
  }

  void add({required WooProduct product}) {
    update(product: product, quantity: 1);
  }

  void remove({required WooProduct product}) {
    cart().deleteItemFromCart(_index(product.id!));
    cart.refresh();
  }

  bool check({required WooProduct product}) {
    return cart().cartItem.indexWhere((c) => c.productId == product.id) != -1;
  }

  void increment({required int product}) {
    cart().incrementItemToCart(_index(product));
    cart.refresh();
  }

  void decrement({required int product}) {
    cart().decrementItemFromCart(_index(product));
    cart.refresh();
  }

  void update(
      {required WooProduct product, required int quantity}) {
    cart().addToCart(
        productId: product.id,
        unitPrice: int.parse(product.price ?? "0"),
        quantity: 1,
        productDetailsObject: {
          'image': Format.image(product.images.first.src)
        });
    cart.refresh();
  }

  void clear() {
    cart().cartItem.clear();
    cart.refresh();
  }

  int _index(int product) {
    return cart().cartItem.indexWhere((c) => c.productId == product);
  }
}
