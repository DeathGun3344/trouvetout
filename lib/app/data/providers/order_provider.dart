import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:trouvetout/app/data/providers/base_provider.dart';

class OrderProvider extends BaseProvider {

  Future<List<WooOrder>> retrieve({required int id, int page = 1}) async {
    return await api.getOrders(
      customer: id,
      perPage: 30,
      page: page
    );
  }

  Future<void> create({required WooOrderPayload payload}) async {
    await api.createOrder(payload);
  }

}