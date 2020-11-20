import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/view/screens/withdraw/confirm_withdraw.dart';

class WithdrawScreen extends StatelessWidget {
  final MoneyMaskedTextController moneyController =
      MoneyMaskedTextController(precision: 2);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        body: Background(
          child: Container(
            height: VtxSizeConfig.screenHeight,
            child: Column(
              children: [
                SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
                WithdrawScreenAppbar(
                  functionChanged: (text) {},
                  moneyController: moneyController,
                  errorText: "errorText",
                ),
                Spacer(),
                VtxButton(
                  text: "Next",
                  color: AppTheme.buttonColorGreen,
                  function: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmWithdraw(),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(13),
                ),
                Text(
                  "or",
                  style: TextStyle(color: AppTheme.textColor),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(25),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: AppTheme.textColor,
                      fontSize: getProportionateScreenWidth(12),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WithdrawScreenAppbar extends StatelessWidget {
  const WithdrawScreenAppbar({
    Key key,
    @required this.functionChanged,
    @required this.moneyController,
    @required this.errorText,
  }) : super(key: key);

  final Function(String p1) functionChanged;
  final MoneyMaskedTextController moneyController;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(95),
      width: VtxSizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppTheme.defaultHorizontalPadding,
            child: Text(
              "Amount to withdraw",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: AppTheme.textColor,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Padding(
            padding: AppTheme.defaultHorizontalPadding,
            child: Container(
              height: getProportionateScreenHeight(72),
              decoration: AppTheme.vtxBuildBoxDecoration(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30),
                    vertical: getProportionateScreenHeight(23)),
                child: Row(
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
                    //NOTE(Geraldo): Correa, tu que fez o texto não dar overflow,
                    //               não foi o controller não. Olha esse Flexible ai
                    Flexible(
                      child: TextField(
                        onChanged: functionChanged,
                        controller: moneyController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(24),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor,
                        ),
                        decoration: InputDecoration(
                          errorText: errorText,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            top: getProportionateScreenHeight(-10),
                          ),
                          hintText: "0,00",
                          hintStyle: TextStyle(
                            fontSize: getProportionateScreenWidth(24),
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
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
