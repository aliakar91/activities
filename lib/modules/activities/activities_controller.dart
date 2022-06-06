import 'package:activity_app_with_getx/models/activity.dart';
import 'package:activity_app_with_getx/repositories/activity_repository.dart';
import 'package:flutter/cupertino.dart';

//import 'package:activity_app_with_getx/repositories/storage_class.dart';
import 'package:get/get.dart';

class ActivitiesController extends GetxController {
  ActivityRepository storageRepository = ActivityRepository();

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

  void searchList(String newSearch) {
    showActivities.value = activities.where((a) => a.activity.toLowerCase().contains(newSearch.toLowerCase())).toList();
    if(showActivities.value.length==0){

    }

    update();
  }

  void readActivityList() async {
    activities = await storageRepository.getAll();
    showActivities.value = List.from(activities);

    update();
  }

}
