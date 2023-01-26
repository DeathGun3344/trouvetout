
import 'package:flutter_wp_woocommerce/models/customer.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trouvetout/app/data/providers/user_provider.dart';
import 'package:trouvetout/app/data/services/address_service.dart';
import 'package:trouvetout/app/data/services/cart_service.dart';

class AuthService extends GetxService {

  int id = 0;
  final Rxn<WooCustomer> _user = Rxn<WooCustomer>();
  WooCustomer? get user => _user();
  bool get isAuth => _user() != null;
  bool get isAnonymous => GetStorage().hasData('anonymous');
  final UserProvider provider = Get.find();

  Future<void> auth() async {
    if(!(await Get.find<WooCommerce>().isCustomerLoggedIn())) {
      return;
    }
    id = (await provider.id())!;
    final WooCustomer user = await provider.auth(
      id: id
    );
    await login(user: user);
  }

  Future<void> anonymous() async {
    await GetStorage().write('anonymous', true);
  }

  Future<void> login({required WooCustomer user}) async {
    id = user.id!;
    _user(user);
    final Rxn<Billing> address = Get.find<AddressService>().address;
    if(address() == null) {
      address(user.billing);
    }
    await Get.find<CartService>().init();
  }

  Future<void> logout() async {
    await Get.find<WooCommerce>().logUserOut();
    id = 0;
    _user.value = null;
    Get.find<CartService>().clear();
    Get.find<AddressService>().address.value = null;
  }
}