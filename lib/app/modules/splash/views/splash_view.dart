import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {

  final double size = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Container(
            height: size,
            width: size,
            color: Colors.black,
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const Spacer(),
                Image.asset("assets/image/logo.png", width: size,),
                const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    )
                )
              ],
            )
          )
        )
      ),
    );
  }
}
