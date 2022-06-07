import 'dart:async';

import 'package:activity_app_with_getx/models/activity.dart';
import 'package:activity_app_with_getx/repositories/activity_repository.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:get/get.dart';

class ActivitiesController extends GetxController {

  ActivityRepository storageRepository = ActivityRepository();

  late StreamSubscription <bool> keyboardSubscription;
  var time = DateTime.now().obs;

  ///instance oluşturuyor

  ///var addedListActivities2 = [].obs; yukarıdaki tanımlama obs (Activity Tipini belirtmek için)
  var showActivities = <Activity>[].obs; //copy list
  var activities = <Activity>[]; //main list
  var newTitle = 'search'.obs;

  void deleteList(Activity activity) {
    storageRepository.delete(activity);
    showActivities.remove(activity);
    update();
  }

  void onReady() {
    super.onReady();
    dateTimeTest();
    var keyboardVisibilityController = KeyboardVisibilityController();
    print('Keyboard Situation: ${keyboardVisibilityController.isVisible}');
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      print('Klavye kapandı : $visible');
    });
  }
  @override
  void onClose() {
    super.onClose();
    keyboardSubscription.cancel();
  }

  void searchList(String newSearch) {
    showActivities.value = activities.where((a) => a.activity.toLowerCase().contains(newSearch.toLowerCase())).toList();
    if (showActivities.value.length == 0) {}
    update();
  }

  void readActivityList() async {
    activities = await storageRepository.getAll();
    showActivities.value = List.from(activities);
    update();
  }

  void dateTimeTest() {
    time.value = DateTime.now();
    Future.delayed(Duration(seconds: 1)).then((_) => dateTimeTest());
  }
}
