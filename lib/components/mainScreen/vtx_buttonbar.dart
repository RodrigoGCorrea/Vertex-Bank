import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

class VtxButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(38),
      ),
      child: Row(
        children: [
          VtxIconButton(
            iconPath: "assets/icons/handshake-solid.svg",
            text: "Pay",
          ),
          Spacer(),
          VtxIconButton(
            iconPath: "assets/icons/money-bill-solid.svg",
            text: "Deposit",
          ),
          Spacer(),
          VtxIconButton(
            iconPath: "assets/icons/hand-holding-usd-solid.svg",
            text: "Withdraw",
          ),
        ],
      ),
    );
  }
}

class VtxIconButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final Function function;

  const VtxIconButton({
    Key key,
    @required this.iconPath,
    @required this.text,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(85),
      height: getProportionateScreenHeight(70),
      decoration: BoxDecoration(
        color: AppTheme.buttonColorGreen,
        borderRadius: BorderRadius.circular(15),
      ),
      child: FlatButton(
        onPressed: () => {},
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: getProportionateScreenWidth(30),
                color: AppTheme.textColor,
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                text,
                style: TextStyle(
                  color: AppTheme.textColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
