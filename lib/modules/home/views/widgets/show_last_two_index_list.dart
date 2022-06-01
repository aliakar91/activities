import 'package:activity_app_with_getx/globals/styles/app_colors.dart';
import 'package:activity_app_with_getx/models/activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowLastTwoIndex extends StatelessWidget {
  final Activity getObject;
  ShowLastTwoIndex(this.getObject);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.primary,
          style: BorderStyle.solid,
        ),
      ),
      child: ListTile(
        leading: Text(getObject.participants.toString()),
        title: Text(getObject.activity),
        trailing: IconButton(
          icon: Icon(
            Icons.star,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
