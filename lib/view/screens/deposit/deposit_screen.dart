import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/view/components/background.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/screens/deposit/confirm_deposit.dart';
import 'package:vertexbank/view/screens/deposit/scan.dart';

class DepositScreen extends StatelessWidget {
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
                    "Scan QR-Code",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      color: AppTheme.textColorLight,
                      fontWeight: AppTheme.generalFontWeight,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(35)),
                  ScanButton(
                    function: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scan(),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Center(
                    child: Text(
                      "or",
                      style: TextStyle(color: AppTheme.textColorLight),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  SelectFromFiles(),
                  Spacer(),
                  Center(
                    child: VtxButton(
                      text: "Next",
                      function: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmDeposit(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectFromFiles extends StatelessWidget {
  final Function function;

  const SelectFromFiles({
    Key key,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: function,
        child: Text(
          "Select QR-Code from files",
          style: TextStyle(
            color: AppTheme.textColorLight,
            fontSize: getProportionateScreenWidth(12),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class ScanButton extends StatelessWidget {
  final Function function;

  const ScanButton({
    Key key,
    @required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: getProportionateScreenHeight(153),
        height: getProportionateScreenHeight(153),
        decoration: BoxDecoration(
          color: AppTheme.buttonColorBlue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: FlatButton(
          onPressed: function,
          child: SvgPicture.asset(
            "assets/icons/qrcode-solid.svg",
            width: double.infinity,
            color: AppTheme.textColorLight,
          ),
        ),
      ),
    );
  }
}
