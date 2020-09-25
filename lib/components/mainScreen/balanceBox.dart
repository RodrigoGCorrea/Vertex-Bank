import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

class BalanceBox extends StatelessWidget {
  const BalanceBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(285),
      height: getProportionateScreenHeight(100),
      decoration: AppTheme.vtxBuildBoxDecoration(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(13),
          horizontal: getProportionateScreenWidth(26),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/wallet-solid.svg",
                  color: AppTheme.textColor,
                  height: getProportionateScreenWidth(16),
                ),
                SizedBox(width: getProportionateScreenWidth(6)),
                Text(
                  "Balance",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: AppTheme.textColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1335,99",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(36),
                    color: AppTheme.textColor,
                  ),
                ),
                Text(
                  "R\$",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(36),
                    color: AppTheme.textColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
