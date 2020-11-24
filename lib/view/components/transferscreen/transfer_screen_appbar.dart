import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class TransferScreenAppBar extends StatelessWidget {
  final Function(String) functionChanged;
  final MoneyMaskedTextController moneyController;
  final String errorText;

  TransferScreenAppBar({
    Key key,
    @required this.functionChanged,
    @required this.moneyController,
    @required this.errorText,
  }) : super(key: key);

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
              "Amount to pay",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: AppTheme.textColorLight,
                fontWeight: AppTheme.generalFontWeight,
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
                        color: AppTheme.textColorDark,
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
                          color: AppTheme.textColorDark,
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
                            color: AppTheme.textColorDark,
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
