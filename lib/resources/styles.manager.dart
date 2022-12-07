import 'package:flutter/material.dart';
import 'font.manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// regular style

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required String fontFamily, required Color color}) {
  return _getTextStyle(
      fontSize, fontFamily, FontWeightManager.regular, color);
}
// light text style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required String fontFamily, required Color color}) {
  return _getTextStyle(
      fontSize, fontFamily, FontWeightManager.light, color);
}
// bold text style

TextStyle getBoldStyle(
    {double fontSize = FontSize.s12, required String fontFamily, required Color color}) {
  return _getTextStyle(
      fontSize, fontFamily, FontWeightManager.bold, color);
}

// semi bold text style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required String fontFamily, required Color color}) {
  return _getTextStyle(
      fontSize, fontFamily, FontWeightManager.semiBold, color);
}


// medium text style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required String fontFamily, required Color color}) {
  return _getTextStyle(
      fontSize, fontFamily, FontWeightManager.medium, color);
}
