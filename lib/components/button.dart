import 'package:flutter/material.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/config/apptheme.dart';

class VtxButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function function;

  const VtxButton({
    Key key,
    this.text,
    this.color = AppTheme.buttonColorGreen,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(118),
      height: getProportionateScreenHeight(37),
      child: FlatButton(
        onPressed: () => function(),
        child: Text(
          text,
          style: TextStyle(
            color: AppTheme.textColor,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        color: color,
      ),
    );
  }
}
