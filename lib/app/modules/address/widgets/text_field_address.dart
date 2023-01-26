import 'package:flutter/material.dart';
import 'package:trouvetout/app/core/const/app_font.dart';

class TextFieldAddress extends StatelessWidget {
  final TextEditingController textEditingController;
  final String lableText;
  final TextInputType type;
  final bool obscure;

  const TextFieldAddress(
      {Key? key, required this.textEditingController, this.obscure = false, required this.lableText, this.type = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
        obscureText: obscure,
        controller: textEditingController,
        keyboardType: type,
        validator: (String? val) {
          if(val == null || val.isEmpty) {
            return "Ce champs est requis";
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: lableText,
          alignLabelWithHint: true, // center labastyle
          labelStyle: AppFont.regular.copyWith(
            fontSize: 13,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
