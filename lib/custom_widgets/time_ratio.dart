import 'package:appointment/controller/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/values_manager.dart';
import '../resources/color_manager.dart';
import 'package:appointment/controller/timeratio_provider.dart';

class TimeRatio extends StatelessWidget {
  TimeRatio({
    super.key,
    required this.myIndex,
    required this.text,
  });

  int myIndex;
  String text;

  @override
  Widget build(BuildContext context) {

    int index = context.watch<TimeRatioProvider>().index;

    return GestureDetector(
      onTap: () {
        context.read<TimeRatioProvider>().changeTimeRatio(myIndex);
        context.read<DataProvider>().selectRatio(myIndex);
      },
      child: Container(
        height: AppSize.s24,
        margin: const EdgeInsets.only(left: AppMargin.m8, right: AppMargin.m8),
        padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ElementRatio.r50),
          color: myIndex == index ? ColorManager.lightPink : Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: myIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
