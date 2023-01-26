import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CustomButton {
  floatingButton(context, String route) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      backgroundColor: ColorManager.darkGreen,
      child: const Icon(Icons.add),
    );
  }

  closeIconButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: CircleAvatar(
        radius: AppSize.s14,
        backgroundColor: ColorManager.lightGreen,
        child: Icon(
          Icons.close_rounded,
          size: AppSize.s24,
          color: ColorManager.darkGreen,
        ),
      ),
    );
  }
}
