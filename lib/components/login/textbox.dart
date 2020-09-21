import 'package:flutter/material.dart';

import '../../assets/apptheme.dart';
import '../../assets/sizeconfig.dart';

class Vtx_TextBox extends StatelessWidget {
  final String text;
  final bool obscureText;

  const Vtx_TextBox({Key key, this.obscureText = false, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: 14,
        color: AppTheme.textColor,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 7 * Vtx_SizeConfig.widthMultiplier),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColor,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textColor,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        labelText: text,
        labelStyle: TextStyle(
          color: AppTheme.textColor,
        ),
      ),
    );
  }
}
