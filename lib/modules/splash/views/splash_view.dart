import 'package:activity_app_with_getx/globals/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:activity_app_with_getx/globals/strings.dart';
import 'package:activity_app_with_getx/modules/splash/splash_controller.dart';
import 'package:activity_app_with_getx/globals/styles/app_text_styles.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put<SplashController>(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.primary,
      body: Center(
        child: Text(
          Strings.appName,
          style: AppTextStyles.splashScreenStyle,
        ),
      ),
    );
  }
}
