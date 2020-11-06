import 'package:flutter/material.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class VtxTextBox extends StatelessWidget {
  final String text;
  final bool obscureText;
  final Function onChangedFunction;
  final TextEditingController controller;

  static double radius = 15;

  const VtxTextBox({
    Key key,
    this.obscureText = false,
    @required this.text,
    this.controller,
    this.onChangedFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChangedFunction,
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
