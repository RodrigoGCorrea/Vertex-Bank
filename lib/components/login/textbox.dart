import 'package:flutter/material.dart';

import '../../assets/apptheme.dart';
import '../../assets/sizeconfig.dart';

class VtxTextBox extends StatelessWidget {
  final String text;
  final bool obscureText;

  static double radius = 15;

  const VtxTextBox({Key key, this.obscureText = false, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: 16,
        color: AppTheme.textColor,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 7 * VtxSizeConfig.widthMultiplier),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColor,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColor,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        labelText: text,
        labelStyle: TextStyle(
          color: AppTheme.textColor,
        ),
      ),
    );
  }
}
