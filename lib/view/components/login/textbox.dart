import 'package:flutter/material.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class VtxTextBox extends StatelessWidget {
  final String text;
  final bool obscureText;
  final Function onChangedFunction;
  final TextEditingController controller;
  final String errorText;

  static double radius = 15;

  const VtxTextBox({
    Key key,
    this.obscureText = false,
    @required this.text,
    this.controller,
    this.onChangedFunction,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(44),
      decoration: AppTheme.vtxBuildBoxDecoration(),
      child: Center(
        child: TextField(
          controller: controller,
          onChanged: onChangedFunction,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            color: AppTheme.textColorDark,
          ),
          obscureText: obscureText,
          decoration: _buildInputDecoration(),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      filled: false,
      fillColor: AppTheme.appBackgroundColor,
      contentPadding: EdgeInsets.only(
        left: getProportionateScreenWidth(18),
        top: getProportionateScreenHeight(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.textColorLight,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.textColorLight,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      hintText: text,
      hintStyle: TextStyle(
        color: AppTheme.textColorDark,
      ),
      errorText: errorText,
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.textColorLight,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.textColorLight,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
