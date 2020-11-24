import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class VtxIconButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final Function function;
  final double width;
  final double height;

  VtxIconButton({
    Key key,
    @required this.iconPath,
    @required this.text,
    @required this.width,
    @required this.height,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.buttonColorBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: FlatButton(
        onPressed: function,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 0.4 * width,
                color: AppTheme.textColorLight,
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                text,
                style: TextStyle(
                  color: AppTheme.textColorLight,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
