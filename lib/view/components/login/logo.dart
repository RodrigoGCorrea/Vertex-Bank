import 'package:flutter/material.dart';
import 'package:vertexbank/config/size_config.dart';

import 'package:vertexbank/config/apptheme.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(235),
      height: getProportionateScreenHeight(111),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(9)),
        decoration: AppTheme.vtxBuildBoxDecoration(),
        child: Column(
          children: [
            Text(
              "VERTEX",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.textColorDark,
                  fontSize: getProportionateScreenWidth(36),
                  fontWeight: FontWeight.w300,
                  fontFamily: "RobotoMono"),
            ),
            Text(
              "BANK",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.textColorDark,
                  fontSize: getProportionateScreenWidth(36),
                  fontWeight: FontWeight.w300,
                  fontFamily: "RobotoMono"),
            )
          ],
        ),
      ),
    );
  }
}
