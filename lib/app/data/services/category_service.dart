import 'package:get/get.dart';
import 'package:trouvetout/app/data/models/category.dart';
import 'package:trouvetout/app/data/providers/category_provider.dart';

class CategoryService extends GetxService {

  final List<Category> categories = [];

  Future<void> init() async {
    categories.addAll(await Get.find<CategoryProvider>().retrieve());
  }

}