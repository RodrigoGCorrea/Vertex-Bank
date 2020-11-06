import 'package:flutter/material.dart';

class VtxSizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = VtxSizeConfig.screenHeight;
  // 640 is the layout height that designer use
  return (inputHeight / 640.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = VtxSizeConfig.screenWidth;
  // 360 is the layout width that designer use
  return (inputWidth / 360.0) * screenWidth;
}
