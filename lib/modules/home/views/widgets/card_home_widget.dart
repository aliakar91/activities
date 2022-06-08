import 'package:activity_app_with_getx/globals/constants.dart';
import 'package:activity_app_with_getx/globals/styles/app_colors.dart';
import 'package:activity_app_with_getx/globals/styles/app_dimens.dart';
import 'package:activity_app_with_getx/modules/home/home_controller.dart';
import 'package:activity_app_with_getx/modules/home/views/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rich_text_widgets.dart';

class CardHomeWidget extends StatelessWidget {
  final HomeController homeController;

  const CardHomeWidget({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myList = [1, 2, 3, 4, 5];
    var descList = [6, 5, 4, 3, 2, 1];
    var ascList = [1, 2, 3, 4, 5, 6];
    return Card(
      elevation: 6,
      margin: AppDimens.homeEdgeInsets,
      shape: RoundedRectangleBorder(borderRadius: AppDimens.borderRadiusLarge),
      child: Column(
        children: [
          Container(
            height: Constants.cardContainerHeight,
            width: Constants.cardContainerWidth,
            margin: AppDimens.homeEdgeInsets,
            decoration: BoxDecoration(
              borderRadius: AppDimens.borderRadiusSmall,
            ),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichTextWidgets(
                      textTitle: 'Activity : '.tr,
                      textActivity: homeController.showActivity.activity.tr,
                    ),
                    RichTextWidgets(
                      textTitle: 'Type : '.tr,
                      textActivity: homeController.showActivity.type.toCapitalized().tr,
                    ),
                    RichTextWidgets(
                      textTitle: 'Participants : '.tr,
                      textActivity: homeController.showActivity.participants.toString(),
                    ),
                    homeController.dolarLira.value==true ? RichTextWidgets(
                      textTitle: 'Price : '.tr,
                      textActivity: '${(homeController.showActivity.price).toString()}\$' ,
                    ): RichTextWidgets(
                      textTitle: 'Price : '.tr,
                      textActivity: '${(homeController.showActivity.price*15).toString()}\₺' ,
                    ),
                    RichTextWidgets(
                      textTitle: 'Key : '.tr,
                      textActivity: homeController.showActivity.key,
                    ),
                    RichTextWidgets(
                      textTitle: 'Accessibility : '.tr,
                      textActivity: homeController.showActivity.accessibility.toString(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    homeController.changeLanguage!=false ?Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColors.secondary),
                      ],
                    )
                    :SizedBox(),
                  ],
                )),
          ),
          Padding(
            padding: AppDimens.paddingHome,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  text: ' Add'.tr,
                  icon: Icons.add,
                  onPressed: () {
                    homeController.addActivityList(homeController.showActivity);
                    homeController.getActivity();
                  },
                ),
                MyButton(
                  text: 'Refresh'.tr,
                  icon: Icons.refresh,
                  onPressed: () {
                    homeController.getActivity();
                    print(myList.sublist(1, 3));
                    print(myList.sublist(1));
                    print('$myList');
                    myList.shuffle();
                    print(descList.reversed.toList());
                    print(ascList.reversed.toList());
                    var sList = ['one', 'two', 'three', 'four'];
                    print(sList.firstWhere((i) => i.length > 3));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
// String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
