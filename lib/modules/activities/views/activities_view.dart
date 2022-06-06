import 'package:activity_app_with_getx/denemeTime/time_deneme.dart';
import 'package:activity_app_with_getx/globals/styles/app_colors.dart';
import 'package:activity_app_with_getx/globals/styles/app_dimens.dart';
import 'package:activity_app_with_getx/main.dart';
import 'package:activity_app_with_getx/models/activity.dart';
import 'package:activity_app_with_getx/modules/activities/activities_controller.dart';
import 'package:activity_app_with_getx/modules/activities/views/widgets/card_widgets.dart';
import 'package:activity_app_with_getx/modules/home/home_controller.dart';
import 'package:activity_app_with_getx/modules/home/views/home_view.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ActivityScreen extends StatelessWidget {
  final ActivitiesController controller = Get.put(ActivitiesController());
  TextEditingController newController = TextEditingController();
  String newTitle = 'search';

  /// final HomeController newController = Get.find() ile başka sayfadaki controllerı bulmamız sağlanır ve
  /// newcontroller.refreshActivities(); fonksiyonunu cagırıp işlem halledilir.
  //final HomeController newController = Get.find();
  ActivityScreen({Key? key}) {
    controller.readActivityList();
  }

  @override
  Widget build(BuildContext context) {
    List<Activity> activities = controller.showActivities;
    return WillPopScope(
      onWillPop: () async {
        Get.find<HomeController>().refreshActivities();
        //newcontroller.refreshActivities();
        print('Geri düğmesine basıldı');
        return true;
      },
      child: GetBuilder<ActivitiesController>(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text('Activities List'),
            centerTitle: true,
          ),
          body: activities.isEmpty
              ? Padding(
                  padding: AppDimens.homeEdgeInsets,
                  child: Center(
                    child: GetBuilder<ActivitiesController>(
                      builder: (_) => Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: AppDimens.borderRadiusMedium,
                                  side: BorderSide(
                                    color: AppColors.primary,
                                    style: BorderStyle.solid,
                                  )),
                              child: TextField(
                                  onTap: () {
                                    controller.newTitle.value = '';
                                    print(controller.newTitle);
                                  },
                                  controller: newController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: AppColors.primary,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        newController.clear();
                                        controller.readActivityList();

                                      },
                                      color: AppColors.primary,
                                    ),
                                    hintText: controller.newTitle.value,
                                    hintStyle: TextStyle(color: AppColors.primary, fontSize: 18),
                                  ),
                                  onChanged: (newSearch) {
                                    controller.searchList(newSearch);
                                    // controller.findList(controller.addedListActivities,newSearch);
                                  }),
                            ),
                            SizedBox(
                              height: 200,
                            ),
                            CircularProgressIndicator(color: AppColors.primary),
                            SizedBox(
                              height: 80,
                            ),
                            Text(
                              'Aranan Aktivite Bulunamadı',
                              style: TextStyle(fontSize: 20, color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: AppDimens.homeEdgeInsets,
                  child: GetBuilder<ActivitiesController>(
                    builder: (_) => Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: AppDimens.borderRadiusMedium,
                              side: BorderSide(
                                color: AppColors.primary,
                                style: BorderStyle.solid,
                              )),
                          child: TextField(
                              onTap: () {
                                controller.newTitle.value = '';
                                print(controller.newTitle);
                              },
                              controller: newController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.primary,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    newController.clear();
                                    controller.readActivityList();

                                  },
                                  color: AppColors.primary,
                                ),
                                hintText: controller.newTitle.value,
                                hintStyle: TextStyle(color: AppColors.primary, fontSize: 18),
                              ),
                              onChanged: (newSearch) {
                                controller.searchList(newSearch);
                                // controller.findList(controller.addedListActivities,newSearch);
                              }),
                        ),

                        Expanded(
                          child: ListView(
                            children: activities
                                .map((activityObject) => CardWidgets(activityObject: activityObject))
                                .toList(),
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
