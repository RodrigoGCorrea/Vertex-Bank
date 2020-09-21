import 'package:flutter/material.dart';
import 'package:vertexbank/assets/apptheme.dart';

class Vtx_Button extends StatelessWidget {
  final String text;
  final Color color;

  const Vtx_Button({
    Key key,
    this.text,
    this.color = AppTheme.buttonColorGreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: FlatButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            color: AppTheme.textColor,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: color,
      ),
    );
  }
}
