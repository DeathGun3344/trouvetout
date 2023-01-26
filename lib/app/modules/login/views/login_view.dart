import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:trouvetout/app/core/const/app_colors.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/data/services/auth_service.dart';
import 'package:trouvetout/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: GestureDetector(
          onTap: () => Get.focusScope?.unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: controller.form,
              child: Container(
                height: Get.height - Get.statusBarHeight,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Connexion",
                      style: AppFont.bold.copyWith(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.2),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: const Offset(1, 1),
                            ),
                          ]),
                      child: TextFormField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? email) {
                          if(email == null || !GetUtils.isEmail(email)) {
                            return 'Veuillez saisir un mail correct';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Email",
                          alignLabelWithHint: true, // center labastyle
                          labelStyle: AppFont.regular.copyWith(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.2),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(1, 1),
                              ),
                            ]),
                        child: Obx(() {
                          return TextFormField(
                            controller: controller.password,
                            obscureText: controller.show(),
                            validator: (String? password) {
                              if (password == null || password.length < 6) {
                                return 'Veuillez saisir 06 caractères minimum';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Mot de passe",
                              suffixIcon: IconButton(
                                onPressed: controller.show.toggle,
                                icon: Icon(
                                  controller.show()
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 16,
                                ),
                              ),
                              alignLabelWithHint: true,
                              // center labastyle
                              labelStyle: AppFont.regular.copyWith(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        })),
                    const SizedBox(
                      height: 25,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColorYellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        onPressed: () {
                          Get.showOverlay(
                              asyncFunction: controller.submit,
                            loadingWidget: const Center(child: CircularProgressIndicator(),)
                          );
                        },
                        child: Text(
                          "Connnexion".toUpperCase(),
                          style: AppFont.medium
                              .copyWith(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        await Get.toNamed(Routes.REGISTER);
                        if(Get.find<AuthService>().isAuth) {
                          controller.next();
                        }
                      },
                      child: Center(
                          child: RichText(
                        text: TextSpan(
                            text: "Vous n'avez pas de compte? ",
                            style: AppFont.medium.copyWith(fontSize: 13),
                            children: [
                              TextSpan(
                                text: "Inscrivez-vous",
                                style: AppFont.bold.copyWith(
                                    fontSize: 13,
                                    color: AppColors.primaryColorRed),
                              )
                            ]),
                      )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Ou',
                        style: AppFont.medium.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: controller.anonymous,
                      child: Center(
                          child: Text(
                        'Connexion anonyme',
                        style: AppFont.bold.copyWith(
                            fontSize: 13, color: AppColors.primaryColorRed),
                      )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
