import 'dart:convert';

import 'package:activity_app_with_getx/globals/constants.dart';
import 'package:activity_app_with_getx/models/activity.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ActivityRepository {
  Future<Activity?> fetchActivity() async {
    final url = Uri.parse(ApiUrls.apiUrl);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = activityFromJson(response.body);
        return result;
      } else {
        print('Api Hatası');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  final listStorage = GetStorage();

  // Future<Activity> get() async {}  

  Future<List<Activity>> getAll() async {
    List<Activity> readActivity = [];

    var storageData = listStorage.read('activity');
    if (storageData != null) {
      var activityData = jsonDecode(storageData);

      for (var task in activityData) {
        var activityObject = Activity.fromJson(task);
        readActivity.add(activityObject);
      }
    }
    return readActivity;
  }

  Future<void> save(List<Activity> activities) async {
    var list = activities.map((activity) => activity.toJson()).toList();
    listStorage.write('activity', jsonEncode(list));
  }

  Future<void> add(Activity activity) async {
    List<Activity> activities = await getAll();
    activities.add(activity);
    save(activities);
  }

  Future<void> delete(Activity activity) async {
    List<Activity> activities = await getAll();
    activities.removeWhere((element) => element.key == activity.key);
    save(activities);
  }
}
