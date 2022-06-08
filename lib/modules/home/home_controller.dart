import 'dart:async';
import 'package:activity_app_with_getx/modules/activities/views/activities_view.dart';
import 'package:activity_app_with_getx/models/activity.dart';
import 'package:activity_app_with_getx/repositories/activity_repository.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class HomeController extends GetxController {
  ActivityRepository activityRepository = ActivityRepository();
  var time = DateTime.now().obs;
  int saat = DateTime.now().hour;
  int dakika = DateTime.now().minute;
  int saniye = DateTime.now().second;
  var changeLanguage = false.obs;
  var dolarLira =false.obs;
  String? timeString;
  final translator = GoogleTranslator();

  ///ActivityRepository'de ki verileri kullanabilmek için instance oluşturuldu.

  var isEmptyOne = Activity(
    activity: "Aktivite Bulunamadı",
    type: "Busywork",
    participants: 1,
    price: 0,
    key: "637835913232",
    accessibility: 0,
  );
  var isEmptyTwo = Activity(
    activity: "2.Aktivie Bulunamadı",
    type: "Busywork",
    participants: 1,
    price: 0,
    key: "637835921353464",
    accessibility: 0,
  );

  var _showActivity = Activity(
    activity: "First Activity",
    type: "Busywork",
    participants: 1,
    price: 0,
    key: "2342122421214",
    accessibility: 0,
  ).obs;

  Activity get showActivity => _showActivity.value;

  set showActivity(value) => _showActivity.value = value;
  var addedListActivities = <Activity>[].obs;

  @override
  void onInit() {
    readActivityList();
    getActivity();
    super.onInit();
  }

  void onReady() {
    dateTimeTest();
  }

  void readActivityList() async {
    addedListActivities.value = await activityRepository.getAll();
    update();
  }

  void dateTimeTest() {
    time.value = DateTime.now();
    Future.delayed(Duration(seconds: 1)).then((_) => dateTimeTest());
  }

  void getActivity() async {
    var getdata = await activityRepository.fetchActivity();
    if (getdata != null) showActivity = getdata;
    print(getdata);
  }

  void goActivitiesPage() {
    Get.to(ActivityScreen());
  }

  void addActivityList(Activity object) {
    activityRepository.add(object);
    addedListActivities.add(object);
    update();
  }

  void refreshActivities() async {
    addedListActivities.value = await activityRepository.getAll();
    update();
  }
}
