import 'package:activity_app_with_getx/modules/activities/views/activities_view.dart';
import 'package:activity_app_with_getx/models/activity.dart';
import 'package:activity_app_with_getx/repositories/activity_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ActivityRepository activityRepository = ActivityRepository();

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

  void readActivityList() async {
    addedListActivities.value = await activityRepository.getAll();
    update();
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

  void controlList() async {


  }
}