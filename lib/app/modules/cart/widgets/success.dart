import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/core/const/app_colors.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/modules/base/controllers/base_controller.dart';

class Success extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: SvgPicture.asset('assets/image/bags.svg'),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text("Succès!",style: AppFont.bold.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("Votre commande sera bientôt livrée.\n Merci d'avoir choisi notre application !!",style: AppFont.regular.copyWith(
                    fontSize: 15,
                    height: 1.3,
                    fontWeight: FontWeight.normal,
                  ),),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 49,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColorYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  textStyle: AppFont.medium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),),
                onPressed: () {
                  Get.back();
                  Get.find<BaseController>().index(0);
                },
                child: Text('Continuer vos achats'.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
