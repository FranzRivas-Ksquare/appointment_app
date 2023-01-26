import 'package:flutter/material.dart';
import '../resources/string_manager.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class AlertManager {
  //Error
  errorMessage() {
    return const Center(child: Text(AppString.error));
  }

  //Sign Up messages
  displaySnackbarSignUp(context, title, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: DurationConstant.d2000),
      content: SizedBox(
        height: AppSize.s100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: AppSize.s28,
              child: Divider(
                height: AppSize.s8,
                color: ColorManager.lightPink,
              ),
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ));
  }

  //Sign Up messages
  displaySnackbarLogIn(context, title, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: DurationConstant.d2000),
        content: SizedBox(
          height: AppSize.s100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: AppSize.s28,
                child: Divider(
                  height: AppSize.s8,
                  color: ColorManager.lightPink,
                ),
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSize.s8,
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        backgroundColor: ColorManager.darkPink));
  }

  //Appointment messages
  displaySnackbarDateTime(context, title, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: DurationConstant.d1500),
      content: SizedBox(
        height: AppSize.s100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: AppSize.s28,
              child: Divider(
                height: AppSize.s8,
                color: ColorManager.auxiliary,
              ),
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSize.s8,
            ),
            Text(
              message,
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ));
  }

  displaySnackbarPicker(context, Widget buttonGallery, Widget buttonCamera) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: DurationConstant.d4000),
      content: SizedBox(
        height: AppSize.s120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: AppSize.s28,
              child: Divider(
                height: AppSize.s8,
                color: ColorManager.darkGreen,
              ),
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            Text(
              AppString.selectOpt,
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 150, child: buttonGallery),
                SizedBox(width: 150, child: buttonCamera),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: ColorManager.colorWhite,
    ));
  }
}
