import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';

import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/vtx_listviewbox.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/view/screens/e_check/generate_e_check.dart';

class ConfirmECheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          height: VtxSizeConfig.screenHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: VtxSizeConfig.screenHeight * 0.1),
            child: Column(
              children: [
                ConfirmWithdrawAppbar(),
                Spacer(),
                VtxButton(
                  text: "Confirm",
                  color: AppTheme.buttonColorGreen,
                  function: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GenerateECheckScreen())),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                CancelButton()
              ],
            ),
          ),
        ),
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

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VtxButton(
      color: AppTheme.buttonColorRed,
      text: "Cancel",
      function: () {
        Navigator.popUntil(
          context,
          ModalRoute.withName('/main'),
        );
      },
    );
  }
}

class ConfirmWithdrawAppbar extends StatelessWidget {
  final MoneyMaskedTextController _moneyController =
      MoneyMaskedTextController(precision: 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(166),
      width: VtxSizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppTheme.defaultHorizontalPadding,
            child: Text(
              "Please confirm this withdraw",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: AppTheme.textColor,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Padding(
            padding: AppTheme.defaultHorizontalPadding,
            child: VtxListViewBox(
              height: getProportionateScreenHeight(70),
              width: getProportionateScreenWidth(285),
              listViewBuilder: WithdrawItem(
                moneyController: _moneyController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WithdrawItem extends StatelessWidget {
  WithdrawItem({
    Key key,
    @required moneyController,
  })  : this.amount = moneyController.text,
        super(key: key);

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
            Column(
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
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
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
