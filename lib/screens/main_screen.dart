import 'package:flutter/material.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/mainScreen/MainScreenAppBar.dart';
import 'package:vertexbank/components/mainScreen/balanceBox.dart';
import 'package:vertexbank/components/mainScreen/transactionList.dart';
import 'package:vertexbank/components/mainScreen/vtx_buttonbar.dart';
import 'package:vertexbank/components/vtx_gradient.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: VtxSizeConfig.screenHeight * 0.1),
              child: MainScreenAppBar(),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            BalanceBox(),
            SizedBox(height: getProportionateScreenHeight(18)),
            TransactionList(),
            SizedBox(height: getProportionateScreenHeight(16)),
            VtxButtonBar(),
          ],
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
      child: VtxGradient(
        color: AppTheme.generalColorGreen,
        begin: Alignment.topLeft,
        child: child,
      ),
    );
  }
}
