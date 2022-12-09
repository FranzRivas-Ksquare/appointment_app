import 'package:flutter/material.dart';

class ColorManager {
  static Color darkGreen = HexColor.fromHex("#416c75");
  static Color lightGreen = HexColor.fromHex("#86aaa6");
  static Color darkPink = HexColor.fromHex("#a6325f");
  static Color lightPink = HexColor.fromHex("#e195bc");
  static Color auxiliary = HexColor.fromHex("#dedce1");
  static Color appBarLightPink = HexColor.fromHex("#f3d5e4");
  static Color appBarDarkPink = HexColor.fromHex("#b34d76");

  static Color backgroundColor = HexColor.fromHex("#eeeeee");
  static Color textColor = HexColor.fromHex("#0d0d0d");

  static Color textFieldBackground = HexColor.fromHex("#E8E8E8");
  static Color textFieldText = HexColor.fromHex("#BDBDBD");

  static Color error = HexColor.fromHex("#FB2576");
  static Color fadeOpacity70 = HexColor.fromHex("#B30d0d0d");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
