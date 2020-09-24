import 'package:flutter/material.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

import '../../assets/apptheme.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 1.5 * VtxSizeConfig.heightMultiplier,
            horizontal: 12 * VtxSizeConfig.widthMultiplier),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.textColor,
            ),
            borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Text(
              "VERTEX",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 5 * VtxSizeConfig.textMultiplier,
                  fontWeight: FontWeight.w300,
                  fontFamily: "RobotoMono"),
            ),
            Text(
              "BANK",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 5 * VtxSizeConfig.textMultiplier,
                  fontWeight: FontWeight.w300,
                  fontFamily: "RobotoMono"),
            )
          ],
        ),
      ),
    );
  }
}
