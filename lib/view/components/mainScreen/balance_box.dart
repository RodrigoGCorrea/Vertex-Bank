import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class BalanceBox extends StatelessWidget {
  const BalanceBox({
    this.money,
    Key key,
  }) : super(key: key);

  final String money;

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
                  color: AppTheme.textColorDark,
                  height: getProportionateScreenWidth(16),
                ),
                SizedBox(width: getProportionateScreenWidth(6)),
                Text(
                  "Balance",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: AppTheme.textColorDark,
                    fontWeight: AppTheme.generalFontWeight,
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
                    color: AppTheme.textColorDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(6)),
                Text(
                  money,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(24),
                    color: AppTheme.textColorDark,
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
