import 'package:flutter/cupertino.dart';
import 'package:vertexbank/config/size_config.dart';

class AppTheme {
  AppTheme._();
  static const Color generalColorGreen = Color(0xFF72C156);
  static const Color generalColorBlue = Color(0xFF6883BA);
  static const Color generalColorWhite = Color(0xFFFFFFFF);
  static const FontWeight generalFontWeight = FontWeight.w300;

  static const Color appBackgroundColor = Color(0xFFECEEED);
  static const Color textColorDark = Color(0xFF0E3040);
  static const Color textColorLight = Color(0xFFECEEED);
  static const Color buttonColorBlue = Color(0xFF0E3040);
  static const Color buttonColorRed = Color(0xFFED174B);

  static EdgeInsets defaultHorizontalPadding = EdgeInsets.symmetric(
    horizontal: VtxSizeConfig.screenWidth * 0.1,
  );

  static BoxDecoration vtxBuildBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: getProportionateScreenWidth(1),
        color: AppTheme.appBackgroundColor,
      ),
      color: AppTheme.appBackgroundColor,
      borderRadius: BorderRadius.circular(20),
    );
  }
}
