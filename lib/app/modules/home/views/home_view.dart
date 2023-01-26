import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trouvetout/app/modules/home/widgets/body.dart';
import 'package:trouvetout/app/modules/home/widgets/header.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              const SizedBox(
                height: 20,
              ),
              Body(),
            ],
          ),
        ),
      ),
    );
  }
}
