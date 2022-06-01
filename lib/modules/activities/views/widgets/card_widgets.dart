import 'package:activity_app_with_getx/globals/styles/app_colors.dart';
import 'package:activity_app_with_getx/globals/styles/app_dimens.dart';
import 'package:activity_app_with_getx/models/activity.dart';
import 'package:activity_app_with_getx/modules/activities/activities_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CardWidgets extends StatelessWidget {
  final Activity activityObject;
  CardWidgets({required this.activityObject});

  final ActivitiesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: AppDimens.borderRadiusMedium,
        side: BorderSide(
          color: AppColors.primary,
          style: BorderStyle.solid,
        ),
      ),
      child: ListTile(
        leading: Text(
          ' ${activityObject.participants}',
        ),
        title: Text(activityObject.activity),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            controller.deleteList(activityObject);
          },
        ),
      ),
    );
  }
}
