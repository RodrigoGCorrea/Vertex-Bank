import 'package:flutter/material.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
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
      width: 38 * Vtx_SizeConfig.widthMultiplier,
      height: 7 * Vtx_SizeConfig.heightMultiplier,
      child: FlatButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            color: AppTheme.textColor,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 * Vtx_SizeConfig.widthMultiplier),
        ),
        color: color,
      ),
    );
  }
}
