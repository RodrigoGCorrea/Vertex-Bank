import 'package:flutter/material.dart';

import '../../assets/apptheme.dart';
import '../../assets/sizeconfig.dart';

class VtxTextBox extends StatelessWidget {
  final String text;
  final bool obscureText;

  static double radius = 15;

  const VtxTextBox({
    Key key,
    this.obscureText = false,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: getProportionateScreenWidth(14),
        color: AppTheme.textColor,
      ),
      obscureText: obscureText,
      decoration: buildInputDecoration(),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(18),
      ),
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
    );
  }
}
