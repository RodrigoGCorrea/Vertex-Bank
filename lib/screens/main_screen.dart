import 'package:flutter/material.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/components/mainScreen/main_screen_appbar.dart';
import 'package:vertexbank/components/mainScreen/balance_box.dart';
import 'package:vertexbank/components/mainScreen/transaction_list.dart';
import 'package:vertexbank/components/mainScreen/vtx_buttonbar.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/models/transaction.dart';

class MainScreen extends StatelessWidget {
  MainScreen({
    Key key,
  }) : super(key: key);

  final List<Widget> transactionList = [
    VtxTransactionItem(
      transaction: Transaction(
        name: "FDP Corp.",
        amount: "1892,30",
        received: true,
        date: DateTime.now(),
      ),
    ),
    VtxTransactionItem(
      transaction: Transaction(
        name: "Jaqueline Marreta",
        amount: "849,72",
        received: false,
        date: DateTime.now(),
      ),
    )
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
              MainScreenAppBar(
                context: context,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              BalanceBox(),
              SizedBox(height: getProportionateScreenHeight(18)),
              TransactionList(
                list: transactionList,
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              VtxButtonBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

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

class _BackgroundOld extends StatelessWidget {
  const _BackgroundOld({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

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
