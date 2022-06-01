import 'package:activity_app_with_getx/globals/styles/app_colors.dart';
import 'package:activity_app_with_getx/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RichTextWidgets extends StatelessWidget {

  final String textTitle;
  final String textActivity;


  RichTextWidgets({required this.textTitle, required this.textActivity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
            text: TextSpan(
                text: textTitle,
                style: TextStyle(color:AppColors.textColor2, fontSize: 17),
                children: <TextSpan>[
                  TextSpan(
                      text:textActivity,
                      style: TextStyle(fontWeight: FontWeight.bold, color:AppColors.textColor3, fontSize: 17)),
                ])),

        SizedBox(height: 10,),
      ],
    );
  }

}