import 'package:flutter_wp_woocommerce/models/customer.dart';
import 'package:trouvetout/app/data/providers/base_provider.dart';

class UserProvider extends BaseProvider {
  Future<int?> id() async {
    return await api.fetchLoggedInUserId();
  }

  Future<WooCustomer> auth({required int id}) async {
    return await api.getCustomerById(id: id);
  }

  Future<WooCustomer> login(
      {required String email, required String password}) async {
    return await api.loginCustomer(username: email, password: password);
  }

  Future<WooCustomer> register(
      {required String email,
      required String password,
      required String name}) async {
    WooCustomer customer =
        WooCustomer(username: name, password: password, email: email);
    bool isOk = await api.createCustomer(customer);
    if (isOk) {
      return customer;
    }
    throw Exception();
  }

  Future<WooCustomer> address(
      {required int id, required Billing billing}) async {
    return await api.updateCustomer(id: id, data: {
      'billing': {
        'phone': billing.phone,
        'address_1': billing.address1,
        'city': billing.city,
      }
    });
  }
}
