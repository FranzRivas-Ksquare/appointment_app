import 'package:flutter/material.dart';

import '../resources/values.manager.dart';
import '../resources/color.manager.dart';

class TimeRatio extends StatelessWidget {
  TimeRatio({super.key, required this.text, required this.isSelect});

  String text;
  bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s24,
      margin: const EdgeInsets.only(
          left: AppMargin.m8,
          right: AppMargin.m8),
      padding: const EdgeInsets.only(
          left: AppPadding.p8,
          right: AppPadding.p8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ElementRatio.r50),
        color: isSelect
            ? ColorManager.lightPink
            : Colors.white,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: isSelect
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }

}