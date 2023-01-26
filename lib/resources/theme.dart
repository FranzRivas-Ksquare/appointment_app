import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

class CustomTextStyle {
  static TextStyle profileName = getSemiBoldStyle(
      color: ColorManager.textColor,
      fontFamily: FontConstants.fontPrimary,
      fontSize: FontSize.s28);

  // static TextStyle profileEmail = getSemiBoldStyle(
  //     color: ColorManager.darkGreen,
  //     fontFamily: FontConstants.fontPrimary,
  //     fontSize: FontSize.s14);

  static TextStyle appointmentTitles = getSemiBoldStyle(
      color: ColorManager.textFieldText,
      fontFamily: FontConstants.fontPrimary,
      fontSize: FontSize.s18);

  static TextStyle appointmentDate = getSemiBoldStyle(
      color: ColorManager.darkPink,
      fontFamily: FontConstants.fontPrimary,
      fontSize: FontSize.s18);

  // static TextStyle appointmentTime = getRegularStyle(
  //     color: ColorManager.textColor,
  //     fontFamily: FontConstants.fontPrimary,
  //     fontSize: FontSize.s18);
}

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
              color: ColorManager.textWhite,
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
              fontSize: FontSize.s16),
        ),
      ),

      // outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle: getSemiBoldStyle(
            color: ColorManager.textWhite,
            fontFamily: FontConstants.fontPrimary,
            fontSize: FontSize.s14),
        backgroundColor: ColorManager.lightGreen,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s28)),
        foregroundColor: ColorManager.auxiliary,
        fixedSize: const Size(AppSize.s160, AppSize.s52),
      )),

      //iconTheme
      iconTheme: IconThemeData(
        color: ColorManager.darkPink,
        opacity: 1.0,
        size: AppSize.s28,
      ),

      // Text theme
      textTheme: TextTheme(
          headline1: getBoldStyle(
              color: ColorManager.textColor,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s28),
          headline2: getSemiBoldStyle(
              color: ColorManager.textWhite,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s26),
          headline3: getBoldStyle(
              color: ColorManager.textColor,
              fontFamily: FontConstants.fontSecundary,
              fontSize: FontSize.s24),
          headline4: getRegularStyle(
              color: ColorManager.darkGreen,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s14),
          headline5: getSemiBoldStyle(
              color: ColorManager.textColor,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s16),
          headline6: getSemiBoldStyle(
              color: ColorManager.textWhite,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s16),
          //--Card due
          subtitle1: getLightStyle(
              color: ColorManager.textFieldText,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s14),
          //--Profile email
          subtitle2: getSemiBoldStyle(
              color: ColorManager.darkGreen,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s14),
          bodyText1: getRegularStyle(
              color: ColorManager.textColor,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s14),
          //--Dialog text
          bodyText2: getMediumStyle(
              color: ColorManager.textColor,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s18),
          //--Alert Text
          caption: getRegularStyle(
              color: ColorManager.auxiliary,
              fontFamily: FontConstants.fontPrimary,
              fontSize: FontSize.s14)),

      //Progress Indicator
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: ColorManager.appBarDarkPink,
        linearTrackColor: ColorManager.appBarLightPink,
        circularTrackColor: ColorManager.lightGreen,
        refreshBackgroundColor: ColorManager.auxiliary,
        linearMinHeight: AppSize.s12,
      ),

      //dialog
      dialogTheme: DialogTheme(
        elevation: ElementElevation.e2,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorManager.colorBlack, width: AppSize.s1),
            borderRadius: const BorderRadius.all(
              Radius.circular(ElementRatio.r20),
            )),
        iconColor: ColorManager.darkGreen,
        backgroundColor: ColorManager.colorWhite,
        titleTextStyle: getSemiBoldStyle(
            color: ColorManager.darkGreen,
            fontFamily: FontConstants.fontPrimary,
            fontSize: FontSize.s24),
        contentTextStyle: getSemiBoldStyle(
            color: ColorManager.darkPink,
            fontFamily: FontConstants.fontPrimary,
            fontSize: FontSize.s18),
        actionsPadding: const EdgeInsets.all(AppPadding.p8),
        alignment: Alignment.center,
      ),

      //SnackBar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorManager.darkPink,
        elevation: ElementElevation.e2,
        contentTextStyle: getSemiBoldStyle(
            color: ColorManager.textWhite,
            fontFamily: FontConstants.fontPrimary,
            fontSize: FontSize.s16),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorManager.colorBlack, width: AppSize.s1),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(ElementRatio.r20),
              bottom: Radius.circular(ElementRatio.r0),
            )),
        behavior: SnackBarBehavior.fixed,
      ),

      // input decoration theme (text form field)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorManager.textFieldBackground,
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(
            fontFamily: FontConstants.fontPrimary,
            color: ColorManager.textFieldBackground), //darkGreen
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
