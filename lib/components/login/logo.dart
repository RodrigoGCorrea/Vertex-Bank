import 'package:flutter/material.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

import '../../assets/apptheme.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(235),
      height: getProportionateScreenHeight(110),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(9)),
        decoration: BoxDecoration(
          border: Border.all(
            width: getProportionateScreenWidth(1),
            color: AppTheme.textColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              "VERTEX",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.textColor,
                  fontSize: getProportionateScreenWidth(36),
                  fontWeight: FontWeight.w300,
                  fontFamily: "RobotoMono"),
            ),
            Text(
              "BANK",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.textColor,
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
