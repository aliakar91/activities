import 'package:activity_app_with_getx/globals/strings.dart';
import 'package:activity_app_with_getx/globals/styles/app_colors.dart';
import 'package:activity_app_with_getx/globals/styles/app_dimens.dart';
import 'package:activity_app_with_getx/globals/styles/app_text_styles.dart';
import 'package:activity_app_with_getx/models/activity.dart';
import 'package:activity_app_with_getx/modules/home/views/widgets/button_widget.dart';
import 'package:activity_app_with_getx/modules/home/home_controller.dart';
import 'package:activity_app_with_getx/modules/home/views/widgets/show_last_two_index_list.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';
import '../../../denemeTime/time_deneme.dart';
import 'widgets/card_home_widget.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final translator = GoogleTranslator();
  final input = ' Hello';

  @override
  Widget build(BuildContext context) {
    List<Activity> listActivity = homeController.addedListActivities;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.lightbulb,
              ),
              //icon: Icon(Icons.lightbulb,color:Colors.black),
              iconSize: 30,
              onPressed: () {
                Get.changeTheme(
                  ThemeData.dark(),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Get.to(Clock());
              },
              child: Text(
                'Activities Pages'.tr,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            IconButton(
              icon: Image.asset('assets/image/123icon.jpg'),
              //icon: Icon(Icons.lightbulb,color: Colors.white,),
              iconSize: 30,
              onPressed: () {
                Get.changeTheme(ThemeData.light());
              },
            ),
            Column(
              children: [
                Obx(
                  () => Text(
                    DateFormat('hh:mm:ss').format(homeController.time.value),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  '${homeController.time.value.day.toString()}' +
                      '/' +
                      '${homeController.time.value.month.toString()}' +
                      '/' +
                      '${homeController.time.value.year.toString()}',
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: AppDimens.homeEdgeInsets,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CardHomeWidget(homeController: homeController),
            Padding(
              padding: AppDimens.homeEdgeInsets,
              child: GetBuilder<HomeController>(
                builder: (_) => listActivity.length >= 2
                    ? Column(
                        children: listActivity.reversed.take(2).map((activity) => ShowLastTwoIndex(activity)).toList(),
                      )
                    : listActivity.length == 1
                        ? Column(
                            children:
                                listActivity.reversed.take(1).map((activity) => ShowLastTwoIndex(activity)).toList(),
                          )
                        : Column(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyButton(
                    text: 'Show List '.tr,
                    icon: Icons.format_list_bulleted_rounded,
                    onPressed: () {
                      homeController.goActivitiesPage();
                      print(listActivity.length);
                    }),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.secondary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    homeController.changeLanguage.value = !homeController.changeLanguage.value;
                    homeController.dolarLira.value = !homeController.dolarLira.value;
                    await Future.delayed(Duration(milliseconds: 420));
                    homeController.changeLanguage.value = !homeController.changeLanguage.value;
                    Get.updateLocale(
                      Get.locale == Locale('tr', 'TR') ? Locale('en', 'US') : Locale('tr', 'TR'),
                    );
                  },
                  label: Row(
                    children: [
                      Text(
                        'Change\nLanguage'.tr,
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  icon: Icon(
                    Icons.change_circle_rounded,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
