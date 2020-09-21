import 'package:flutter/material.dart';

import '../../assets/apptheme.dart';

class Textbox extends StatelessWidget {
  final String text;
  final bool obscureText;

  const Textbox({Key key, this.obscureText = false, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: SizedBox(
        width: double.maxFinite,
        child: TextField(
          style: TextStyle(
            color: AppTheme.textColor,
          ),
          obscureText: obscureText,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppTheme.textColor,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppTheme.textColor,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              labelText: text,
              labelStyle: TextStyle(
                color: AppTheme.textColor,
              )),
        ),
      ),
    );
  }
}
