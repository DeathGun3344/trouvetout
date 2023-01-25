import 'package:trouvetout/app/data/models/order.dart';
import 'package:trouvetout/app/data/providers/base_provider.dart';

class OrderProvider extends BaseProvider {

  Future<List<Order>> retrieve() async {

    var response = await api.getAsync("orders");

    return Order.fromList(response);

  }
}