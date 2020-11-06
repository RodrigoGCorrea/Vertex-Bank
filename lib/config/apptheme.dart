import 'package:flutter/cupertino.dart';
import 'package:vertexbank/config/size_config.dart';

class AppTheme {
  AppTheme._();
  static const Color generalColorGreen = Color(0xFF72C156);
  static const Color generalColorBlue = Color(0xFF6883BA);

  static const Color appBackgroundColor = Color(0xFF030708);
  static const Color textColor = Color(0xFFE5E5E5);
  static const Color buttonColorGreen = Color(0xFF72C156);
  static const Color buttonColorRed = Color(0xFFED174B);

  static EdgeInsets defaultHorizontalPadding = EdgeInsets.symmetric(
    horizontal: VtxSizeConfig.screenWidth * 0.1,
  );

  static BoxDecoration vtxBuildBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: getProportionateScreenWidth(1),
        color: AppTheme.textColor,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
