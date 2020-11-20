import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/models/withdraw.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/vtx_listviewbox.dart';

class ConfirmDeposit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Padding(
          padding: AppTheme.defaultHorizontalPadding,
          child: Container(
            height: VtxSizeConfig.screenHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: VtxSizeConfig.screenHeight * 0.1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please confirm this deposit",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5)),
                  VtxListViewBox(
                    height: getProportionateScreenHeight(190),
                    width: getProportionateScreenWidth(285),
                    listViewBuilder: DepositItem(
                      name: "pessoa com nome muito grande",
                      amount: "200000911111111,00",
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: VtxButton(
                      text: "Confirm",
                      color: AppTheme.buttonColorGreen,
                      function: () {},
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  CancelButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DepositItem extends StatelessWidget {
  DepositItem({
    Key key,
    @required this.name,
    @required this.amount,
  }) : super(key: key);

  final String name;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(12)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(4)),
              child: SvgPicture.asset(
                "assets/icons/circle-solid.svg",
                width: getProportionateScreenWidth(4),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "From",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Text(
                    name,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(28)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(4)),
              child: SvgPicture.asset(
                "assets/icons/circle-solid.svg",
                width: getProportionateScreenWidth(4),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "The amount of",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Text(
                    "R\$ $amount",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(28)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(4)),
              child: SvgPicture.asset(
                "assets/icons/circle-solid.svg",
                width: getProportionateScreenWidth(4),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "On the day",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Text(
                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: VtxButton(
        color: AppTheme.buttonColorRed,
        text: "Cancel",
        function: () {
          Navigator.popUntil(
            context,
            ModalRoute.withName('/main'),
          );
        },
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: VtxSizeConfig.screenWidth,
      height: VtxSizeConfig.screenHeight,
      color: AppTheme.appBackgroundColor,
      child: child,
    );
  }
}
