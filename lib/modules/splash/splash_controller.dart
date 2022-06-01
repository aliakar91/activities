import 'package:activity_app_with_getx/globals/constants.dart';
import 'package:get/get.dart';

import '../home/views/home_view.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Future.delayed(Duration(milliseconds: Constants.splashDuration), () {
      Get.to(() => HomeScreen());
    });
  }
}
