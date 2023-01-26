import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:trouvetout/app/core/const/app_colors.dart';
import 'package:trouvetout/app/modules/cart/views/cart_view.dart';
import 'package:trouvetout/app/modules/home/views/home_view.dart';
import 'package:trouvetout/app/modules/personal/views/personal_view.dart';
import 'package:trouvetout/app/modules/products/views/products_view.dart';

import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.page,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeView(),
          ProductsView(),
          CartView(),
          PersonalView()
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.black,
            currentIndex: controller.index(),
            onTap: controller.index,
            items: [
              bottom(label: 'Accueil', icon: 'home'),
              bottom(label: 'Produits', icon: 'categories'),
              bottom(label: 'Panier', icon: 'bag'),
              bottom(label: 'Profil', icon: 'profile'),
            ],
          );
        }
      ),
    );
  }

  BottomNavigationBarItem bottom({required String label, required String icon}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/image/${icon}_inactive.svg'),
      label: label,
      activeIcon: SvgPicture.asset('assets/image/${icon}_active.svg', color: AppColors.primaryColorYellow,)
    );
  }

}
