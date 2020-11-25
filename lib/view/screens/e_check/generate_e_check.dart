import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/models/e_check.dart';
import 'package:vertexbank/view/components/background.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/vtx_icon_button.dart';

class GenerateECheckScreen extends StatelessWidget {
  const GenerateECheckScreen({
    @required this.eCheck,
  });

  final ECheck eCheck;

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
              GenerateCheckScreenAppbar(
                eCheck: eCheck,
              ),
              Spacer(),
              VtxButton(
                text: "Back to menu",
                //Before this screen been pushed we remove every other screen from the stack
                //that's why we don't need to popUntil here
                function: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GenerateCheckScreenAppbar extends StatefulWidget {
  const GenerateCheckScreenAppbar({@required this.eCheck});
  final ECheck eCheck;

  @override
  _GenerateCheckScreenAppbarState createState() =>
      _GenerateCheckScreenAppbarState();
}

class _GenerateCheckScreenAppbarState extends State<GenerateCheckScreenAppbar> {
  GlobalKey _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(220),
      child: Padding(
        padding: AppTheme.defaultHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please, make sure to save your E-Check",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: AppTheme.textColorLight,
                fontWeight: AppTheme.generalFontWeight,
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
                    _qRCodeBuilder(
                      widget.eCheck.toJson(),
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ShareButton(
                          onPressed: () async {
                            final qrFileName =
                                await _saveQrCodeAsImageAndReturnItsFilename();
                            final amount = NumberFormat.currency(
                                    locale: 'pt_BR', symbol: "R\$")
                                .format(widget.eCheck.amount * 0.01);
                            Share.shareFiles([qrFileName],
                                text: "Here's your E-Check of $amount");
                          },
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

  Future<String> _saveQrCodeAsImageAndReturnItsFilename() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final date = DateTime.now().toIso8601String();
      final fileName = '${tempDir.path}/e-check_$date.png';

      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final file = await new File(fileName).create();
      await file.writeAsBytes(pngBytes);

      return fileName;
    } catch (e) {
      //I hope this never reaches...
      throw e;
    }
  }

  Widget _qRCodeBuilder(String data) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: getProportionateScreenWidth(170),
          height: getProportionateScreenHeight(150),
          decoration: BoxDecoration(
            color: AppTheme.textColorLight,
            border: Border.all(
              width: getProportionateScreenWidth(1),
              color: AppTheme.textColorDark,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Container(
          child: RepaintBoundary(
            key: _globalKey,
            child: QrImage(
              data: data,
              version: QrVersions.auto,
              size: 180,
              backgroundColor: AppTheme.textColorLight,
            ),
          ),
        ),
      ],
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return VtxIconButton(
      iconPath: "assets/icons/share-alt-solid.svg",
      text: "share",
      function: onPressed,
      width: getProportionateScreenWidth(65),
      height: getProportionateScreenHeight(55),
    );
  }
}

class QRCodeBuilder extends StatelessWidget {
  final String data;

  const QRCodeBuilder({
    GlobalKey key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: getProportionateScreenWidth(170),
          height: getProportionateScreenHeight(150),
          decoration: BoxDecoration(
            color: AppTheme.textColorDark,
            border: Border.all(
              width: getProportionateScreenWidth(1),
              color: AppTheme.textColorDark,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        RepaintBoundary(
          key: key,
          child: QrImage(
            data: data,
            version: QrVersions.auto,
            size: 190,
          ),
        ),
      ],
    );
  }
}
