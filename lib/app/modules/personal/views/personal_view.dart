import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/data/models/user.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';
import 'package:trouvetout/app/modules/base/controllers/base_controller.dart';
import 'package:trouvetout/app/routes/app_pages.dart';

import '../controllers/personal_controller.dart';

class PersonalView extends GetView<PersonalController> {

  final AuthService service = Get.find();
  late final User? user = service.user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(user?.avatar ?? ""),
                      fit: BoxFit.cover
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? "",
                      style: AppFont.semiBold.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      user?.email ?? "",
                      style: AppFont.medium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),

          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                tile(title: 'Mes commandes', subtitle: 'Liste de mes commandes', onTap: () => Get.toNamed(Routes.ORDERS)),
                tile(title: 'Deconnexion', subtitle: 'Fermer la session', onTap: () {
                  Get.defaultDialog(
                    title: "Confirmation",
                    content: const Text("Cliquez sur OK pour vous deconnecter"),
                    textConfirm: "OK",
                    textCancel: "Fermer",
                    onConfirm: () {
                      service.logout();
                      Get.back();
                      Get.find<BaseController>().index(0);
                    }
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tile({required String title, required String subtitle, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      onTap: onTap,
      title: Text(
        title,
        style: AppFont.semiBold.copyWith(
            fontWeight: FontWeight.bold, fontSize: 17),
      ),
      subtitle: Text(
        subtitle,
        style: AppFont.regular.copyWith(
            fontWeight: FontWeight.w100,
            fontSize: 13,
            color: Colors.grey),
      ),
      trailing: IconButton(
        onPressed: onTap,
        icon: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Colors.grey,
        ),
      ),
    );
  }

}
