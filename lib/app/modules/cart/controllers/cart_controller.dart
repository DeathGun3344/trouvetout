import 'package:flutter_wp_woocommerce/models/customer.dart';
import 'package:flutter_wp_woocommerce/models/order_payload.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/data/providers/order_provider.dart';
import 'package:trouvetout/app/data/services/address_service.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';
import 'package:trouvetout/app/data/services/cart_service.dart';

class CartController extends GetxController {

  Future<void> submit() async {
    final Billing address = Get.find<AddressService>().address()!;
    Get.find<OrderProvider>().create(payload: WooOrderPayload(
        billing: WooOrderPayloadBilling(
            phone: address.phone,
            city: address.city,
            address1: address.address1,
          lastName: address.lastName
        ),
        shipping: WooOrderPayloadShipping(
            city: address.city,
            address1: address.address1,
            lastName: address.lastName
        ),
        customerId: Get.find<AuthService>().id,
        lineItems: Get.find<CartService>().cart().cartItem.map(
                (i) => LineItems(
                  productId: i.productId,
                  name: i.productName,
                  quantity: i.quantity,
                )
        ).toList()
    ));

    Get.find<CartService>().clear();
  }

}
