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
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.textColor,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(
              "Vertex",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 5 * SizeConfig.textMultiplier,
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              "Bank",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 5 * SizeConfig.textMultiplier,
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.w100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
