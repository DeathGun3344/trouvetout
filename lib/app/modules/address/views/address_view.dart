import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trouvetout/app/core/const/app_colors.dart';
import 'package:trouvetout/app/core/const/app_font.dart';
import 'package:trouvetout/app/modules/address/widgets/text_field_address.dart';

import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Mettre a jour l'adresse de livraison",
          style: AppFont.semiBold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: Get.focusScope?.unfocus,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            child: Form(
              key: controller.form,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddress(
                    textEditingController: controller.name,
                    type: TextInputType.name,
                    lableText: "Nom & Prénoms",
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextFieldAddress(
                      textEditingController: controller.phone,
                      type: TextInputType.phone,
                      lableText: "Numéro de téléphone"),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    child: DropdownButtonFormField(
                        validator: (String? val) {
                          if(val == null || val.isEmpty) {
                            return "Ce champs est requis";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Ville",
                          alignLabelWithHint: true, // center labastyle
                          labelStyle: AppFont.regular.copyWith(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        items: ["Abidjan", "Bouaké"]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        value: controller.city(),
                        onChanged: controller.city),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextFieldAddress(
                      textEditingController: controller.address,
                      lableText: "Adresse"),
                  const SizedBox(
                    height: 40,
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
                        ),
                      ),
                      onPressed: controller.submit,
                      child: Text('enregistrer l\'adresse'.toUpperCase()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
