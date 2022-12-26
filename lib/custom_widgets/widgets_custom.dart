import 'dart:io';

import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CustomWidgets {
  columnColors(BuildContext context, Color colorBack) {
    return Column(
      children: <Widget>[
        Container(
          color: colorBack,
          height: AppSize.s110,
          width: double.infinity,
        ),
        const SizedBox(
          height: AppSize.s60,
          width: double.infinity,
        ),
      ],
    );
  }

  containerColors(BuildContext context, Color colorBack) {
    return Container(
      color: colorBack,
      height: AppSize.s110,
      width: double.infinity,
    );
  }

  // TODO: check types
  circleAvatarProfile(BuildContext context, ImageProvider getAvatar) {
    return CircleAvatar(
      radius: AppSize.s84,
      backgroundColor: ColorManager.backgroundColor,
      child: CircleAvatar(
        radius: AppSize.s80,
        backgroundImage: getAvatar,
      ),
    );
  }

  containerAvatarProfile(context, imagePath) {
    return Container(
        height: AppSize.s160,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover, image: FileImage(File(imagePath)))));
  }
}
