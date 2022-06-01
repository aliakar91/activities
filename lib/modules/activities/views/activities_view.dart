import 'package:activity_app_with_getx/globals/styles/app_colors.dart';
import 'package:activity_app_with_getx/globals/styles/app_dimens.dart';
import 'package:activity_app_with_getx/main.dart';
import 'package:activity_app_with_getx/models/activity.dart';
import 'package:activity_app_with_getx/modules/activities/activities_controller.dart';
import 'package:activity_app_with_getx/modules/activities/views/widgets/card_widgets.dart';
import 'package:activity_app_with_getx/modules/home/home_controller.dart';
import 'package:activity_app_with_getx/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ActivityScreen extends StatelessWidget {
  final ActivitiesController controller = Get.put(ActivitiesController());

  /// final HomeController newController = Get.find() ile başka sayfadaki controllerı bulmamız sağlanır ve
  /// newcontroller.refreshActivities(); fonksiyonunu cagırıp işlem halledilir.
  //final HomeController newController = Get.find();
  ActivityScreen({Key? key}) {
    controller.readActivityList();
  }

  @override
  Widget build(BuildContext context) {
    List<Activity> activities = controller.addedListActivities;
    return WillPopScope(
      onWillPop: () async {
        Get.find<HomeController>().refreshActivities();
        //newcontroller.refreshActivities();
        print('Geri düğmesine basıldı');
        return true;
      },
      child:GetBuilder<ActivitiesController> (builder:(_)=>  Scaffold(
        appBar: AppBar(
          title: Text('Activities List'),
          centerTitle: true,
        ),
        body: activities.isEmpty
            ? Center(
                child: GetBuilder<ActivitiesController>(
                builder: (_) => Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppColors.primary),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Eklenen Aktivite Bulunamadı',
                      style: TextStyle(fontSize: 20, color: AppColors.primary),
                    ),
                  ],
                )),
              ))
            : Padding(
                padding: AppDimens.homeEdgeInsets,
                child: GetBuilder<ActivitiesController>(
                    builder: (_) => ListView(
                          physics: BouncingScrollPhysics(),
                          children:
                              activities.map((activityObject) => CardWidgets(activityObject: activityObject)).toList(),
                        )),
              ),
      ),
      ),
    );
  }
}
