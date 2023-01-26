import 'package:trouvetout/app/data/models/category.dart';
import 'package:trouvetout/app/data/providers/base_provider.dart';

class CategoryProvider extends BaseProvider {

  Future<List<Category>> retrieve() async {

    var response = await api.getAsync("products/categories?parent=0&hide_empty=true&per_page=100");

    return Category.fromList(response);

  }
}