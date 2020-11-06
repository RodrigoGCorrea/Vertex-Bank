import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class BalanceBox extends StatelessWidget {
  const BalanceBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(285),
      height: getProportionateScreenHeight(85),
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
                    fontWeight: FontWeight.w100,
                  ),
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              children: [
                Text(
                  "R\$",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(24),
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(6)),
                Text(
                  "13350,99",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(24),
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.bold,
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
