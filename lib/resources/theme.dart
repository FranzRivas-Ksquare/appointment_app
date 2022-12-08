import 'color.manager.dart';
import 'font.manager.dart';
import 'styles.manager.dart';
import 'values.manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.darkGreen,
      primaryColorLight: ColorManager.lightGreen,
      primaryColorDark: ColorManager.darkPink,
      disabledColor: ColorManager.auxiliary,
      // ripple color
      splashColor: ColorManager.lightGreen,
      // will be used in case of disabled button for example
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.backgroundColor,
          shadowColor: ColorManager.auxiliary,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.darkPink,
          elevation: AppSize.s0,
          toolbarHeight: AppSize.s100,
          //shadowColor: ColorManager.fadeOpacity70,
          titleTextStyle: getSemiBoldStyle(
              color: Colors.white, //ColorManager.auxiliary
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s28)),
      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.auxiliary,
          buttonColor: ColorManager.darkGreen,
          splashColor: ColorManager.lightGreen),
      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle: getSemiBoldStyle(
            color: ColorManager.auxiliary,
            fontFamily: FontConstants.fontPrimary,
            fontSize: FontSize.s14),
        backgroundColor: ColorManager.darkGreen,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s28)),
        minimumSize: const Size.fromHeight(AppSize.s52),
      )),

      //text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorManager.darkPink,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: getSemiBoldStyle(
              color: ColorManager.auxiliary,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s14),
        ),
      ),

      // Text theme
      textTheme: TextTheme(
          headline1: getBoldStyle(
              color: ColorManager.textColor,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s28),
          headline2: getRegularStyle(
              color: ColorManager.auxiliary,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s16),
          headline3: getBoldStyle(
              color: ColorManager.darkGreen,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s16),
          headline4: getRegularStyle(
              color: ColorManager.darkGreen,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s14),
          subtitle1: getMediumStyle(
              color: ColorManager.lightPink,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s14),
          subtitle2: getMediumStyle(
              color: ColorManager.darkGreen,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s14),
          bodyText2: getMediumStyle(
              color: ColorManager.lightPink,
              fontFamily: FontConstants.fontPrimary),
          caption: getRegularStyle(
              color: ColorManager.auxiliary,
              fontFamily: FontConstants.fontPrimary),
          bodyText1: getRegularStyle(
              color: ColorManager.auxiliary,
              fontFamily: FontConstants.fontPrimary)),

      // input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(
            fontFamily: FontConstants.fontPrimary,
            color: ColorManager.textFieldBackground),
        // label style
        labelStyle: getMediumStyle(
            fontFamily: FontConstants.fontPrimary,
            color: ColorManager.textFieldText),
        // error style
        errorStyle: getRegularStyle(
            fontFamily: FontConstants.fontPrimary, color: ColorManager.error),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.auxiliary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.darkGreen, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
