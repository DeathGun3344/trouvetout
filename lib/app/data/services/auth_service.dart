
import 'package:get/get.dart';
import 'package:trouvetout/app/data/models/address.dart';
import 'package:trouvetout/app/data/models/user.dart';
import 'package:trouvetout/app/data/providers/user_provider.dart';
import 'package:trouvetout/app/data/services/address_service.dart';
import 'package:trouvetout/app/data/services/cart_service.dart';

class AuthService extends GetxService {

  final Rxn<User> _user = Rxn<User>();
  User? get user => _user();
  bool get isAuth => _user() != null;
  bool get isAnonymous => true;
  final UserProvider provider = Get.find();

  Future<void> auth() async {
    await Future.delayed(const Duration(seconds: 1));
    if(false) {
      return;
    }
    final User user = await provider.auth();
    _user(user);
    Get.find<AddressService>().address(user.address);
  }

  Future<void> anonymous() async {
    //isAnonymous = true;
  }

  void login({required User user}) {
    _user(user);
    final Rxn<Address> address = Get.find<AddressService>().address;
    if(address() == null) {
      address(user.address);
    }
  }

  void logout() {
    _user.value = null;
    Get.find<CartService>().cart.clear();
    Get.find<AddressService>().address.value = null;
  }
}