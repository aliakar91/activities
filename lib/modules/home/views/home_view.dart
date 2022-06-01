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
import 'widgets/card_home_widget.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    List<Activity> listActivity = homeController.addedListActivities;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.lightbulb),
              iconSize: 30,
              onPressed: () {
                Get.changeTheme(ThemeData.light());
              },
            ),
            Text(
              Strings.activityName,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            IconButton(
              icon: Icon(Icons.lightbulb_outline),
              iconSize: 30,
              onPressed: () {
                Get.changeTheme(ThemeData.dark());
              },
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
            MyButton(
                text: 'Listeyi Görüntüle',
                icon: Icons.format_list_bulleted_rounded,
                onPressed: () {
                  homeController.goActivitiesPage();
                  print(listActivity.length);
                }),
          ],
        ),
      ),
    );
  }
}
