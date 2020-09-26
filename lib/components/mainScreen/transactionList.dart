import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: getProportionateScreenWidth(285),
        height: getProportionateScreenHeight(187),
        decoration: AppTheme.vtxBuildBoxDecoration(),
        child: Row(
          children: [
            SizedBox(
              height: double.infinity,
              width: getProportionateScreenWidth(31),
            ),
            VerticalDivider(
              color: AppTheme.textColor,
              thickness: 1.5,
            ),
            Container(
              width: getProportionateScreenWidth(205),
              height: double.infinity,
              child: ListView(),
            ),
            Container(
              width: getProportionateScreenWidth(31),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/chevron-right-solid.svg",
                    width: getProportionateScreenWidth(13),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5)),
                  Text(
                    "More",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(11),
                      color: AppTheme.textColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
