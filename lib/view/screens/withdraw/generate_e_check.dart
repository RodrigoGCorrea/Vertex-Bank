import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/models/withdraw.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/vtx_icon_button.dart';

class GenerateCheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: VtxSizeConfig.screenHeight * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GenerateCheckScreenAppbar(),
              Spacer(),
              VtxButton(
                text: "Back to menu",
                function: () {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName('/main'),
                  );
                },
              )
            ],
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

class GenerateCheckScreenAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Withdraw withdraw =
        Withdraw(senderID: "teste", amount: 140, checkID: "brabo");
    return Container(
      height: getProportionateScreenHeight(220),
      child: Padding(
        padding: AppTheme.defaultHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please save your QR-Code",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: AppTheme.textColor,
                fontWeight: FontWeight.w100,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            Container(
              height: getProportionateScreenHeight(195),
              decoration: AppTheme.vtxBuildBoxDecoration(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(23),
                  horizontal: getProportionateScreenWidth(18),
                ),
                child: Row(
                  children: [
                    QRCodeBuilder(
                      data: withdraw.toJson(),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        VtxIconButton(
                          iconPath: "assets/icons/file-download-solid.svg",
                          text: "save",
                          width: getProportionateScreenWidth(65),
                          height: getProportionateScreenHeight(55),
                        ),
                        Spacer(),
                        VtxIconButton(
                          iconPath: "assets/icons/share-alt-solid.svg",
                          text: "share",
                          width: getProportionateScreenWidth(65),
                          height: getProportionateScreenHeight(55),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QRCodeBuilder extends StatelessWidget {
  final String data;

  const QRCodeBuilder({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: getProportionateScreenWidth(170),
          height: getProportionateScreenHeight(150),
          decoration: BoxDecoration(
            color: AppTheme.textColor,
            border: Border.all(
              width: getProportionateScreenWidth(1),
              color: AppTheme.textColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        QrImage(
          data: data,
          version: QrVersions.auto,
          size: 190,
        ),
      ],
    );
  }
}
