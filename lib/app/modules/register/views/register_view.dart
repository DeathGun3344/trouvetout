import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trouvetout/app/core/const/app_colors.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/modules/address/widgets/text_field_address.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: GestureDetector(
          onTap: Get.focusScope?.unfocus,
          child: SingleChildScrollView(
            child: Form(
              key: controller.form,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Inscription",
                      style: AppFont.bold.copyWith(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFieldAddress(
                        textEditingController: controller.name,
                        lableText: "Nom & Prenoms",
                      type: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldAddress(
                        textEditingController: controller.email,
                        lableText: "Email",
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFieldAddress(
                        textEditingController: controller.password,
                        lableText: "Mot de passe",
                      obscure: true,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: Get.back,
                        child: Text(
                          "Vous avez déja un compte?",
                          style: AppFont.medium.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                            loadingWidget: const Center(
                              child: CircularProgressIndicator(),
                            )
                          );
                        },
                        child: Text(
                          "Inscription".toUpperCase(),
                          style: AppFont.medium
                              .copyWith(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
