import 'dart:async';
import 'package:activity_app_with_getx/globals/styles/app_colors.dart';
import 'package:activity_app_with_getx/globals/styles/app_dimens.dart';
import 'package:activity_app_with_getx/models/activity.dart';
import 'package:activity_app_with_getx/modules/activities/activities_controller.dart';
import 'package:activity_app_with_getx/modules/activities/views/widgets/card_widgets.dart';
import 'package:activity_app_with_getx/modules/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class ActivityScreen extends StatelessWidget {
  final ActivitiesController controller = Get.put(ActivitiesController());
  var keyboardVisibilityController = KeyboardVisibilityController();
  late StreamSubscription<bool> keyboardSubscription;
  TextEditingController newController = TextEditingController();
  String newTitle = 'search';
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool newHintText = true;
  final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance.window.viewInsets, WidgetsBinding.instance.window.devicePixelRatio);

  /// final HomeController newController = Get.find() ile başka sayfadaki controllerı bulmamız sağlanır ve
  /// newcontroller.refreshActivities(); fonksiyonunu cagırıp işlem halledilir.
  //final HomeController newController = Get.find();
  ActivityScreen({Key? key}) {
    controller.readActivityList();
  }

  @override
  Widget build(BuildContext context) {
    abc(context);

    MediaQuery.of(context).viewInsets.bottom;
    List<Activity> activities = controller.showActivities;

    return WillPopScope(
      onWillPop: () async {
        Get.find<HomeController>().refreshActivities();
        newHintText = false;
        print('Geri düğmesine basıldı ${newHintText}');
        return true;
      },
      child: GetBuilder<ActivitiesController>(
        builder: (_) => Scaffold(
          key: _scaffoldkey,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Activities List'.tr),
                Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('hh:mm:ss').format(controller.time.value),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${controller.time.value.day.toString()}' +
                            '/' +
                            '${controller.time.value.month.toString()}' +
                            '/' +
                            '${controller.time.value.year.toString()}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                                  autocorrect: true,
                                  autofocus: true,
                                  onTap: () {
                                    controller.newTitle.value = '';
                                    print(controller.newTitle);
                                    controller.update();
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
                                        newHintText = false;
                                        newController.clear();
                                        controller.readActivityList();
                                      },
                                      color: AppColors.primary,
                                    ),

                                    ///Hint Text Değişikliği yapılacak
                                    hintText: newHintText == false ? controller.newTitle.value : '',
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
                              height: 40,
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
                    builder: (_) => GestureDetector(
                      onTap: () {
                        newHintText = false;
                        FocusScope.of(context).unfocus();
                        print('focus calısto');
                        print(newHintText);
                      },
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: AppDimens.borderRadiusMedium,
                                side: BorderSide(
                                  color: AppColors.primary,
                                  style: BorderStyle.solid,
                                )),
                            child: TextField(
                                autofocus: true,
                                keyboardType: TextInputType.visiblePassword,
                                onTap: () {
                                  newHintText = true;
                                  controller.newTitle.value = '';
                                  print(controller.newTitle);
                                  controller.update();
                                  print(newHintText);
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
                                      newHintText = false;
                                      newController.clear();
                                      controller.readActivityList();
                                    },
                                    color: AppColors.primary,
                                  ),
                                  hintText: newHintText == false ? 'Search'.tr : '',
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
      ),
    );
  }

  void abc(BuildContext context) {
    print('Keyboard Situation: ${keyboardVisibilityController.isVisible}');
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      if (visible == true) {
        print('Klavye açıldı : $visible');
      } else {
        FocusScope.of(context).unfocus();
        newHintText = false;
        print('Klavye kapandı  visible durumu = $visible ');
      }
    });
  }
}
