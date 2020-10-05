import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

class TransferScreenAppBar extends StatelessWidget {
  final MoneyMaskedTextController controller;

  const TransferScreenAppBar({
    Key key,
    @required this.controller,
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
                    Flexible(
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(24),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor,
                        ),
                        decoration: InputDecoration(
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