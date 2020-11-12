import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/components/vtx_listviewbox.dart';
import 'package:vertexbank/cubit/transfer/transfer_cubit.dart';
import 'package:vertexbank/models/transaction.dart';

class TransferScreenConfirm extends StatelessWidget {
  const TransferScreenConfirm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<TransferCubit>().cleanUpSelected();
        return Future.value(true);
      },
      child: Scaffold(
        body: _Background(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
                ConfirmTransferAppbar(),
                SizedBox(height: getProportionateScreenHeight(94)),
                VtxButton(
                  color: AppTheme.buttonColorGreen,
                  text: "Confirm",
                ),
                SizedBox(height: getProportionateScreenHeight(94)),
                VtxButton(
                  color: AppTheme.buttonColorRed,
                  text: "Cancel",
                  function: () {
                    context.read<TransferCubit>().cleanUpInitial();
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName('/main'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmTransferAppbar extends StatelessWidget {
  const ConfirmTransferAppbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(234),
      width: VtxSizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppTheme.defaultHorizontalPadding,
            child: Text(
              "Please confirm this transaction",
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
              height: getProportionateScreenHeight(190),
              width: getProportionateScreenWidth(285),
              listViewBuilder: BlocBuilder<TransferCubit, TransferScreenState>(
                buildWhen: (previous, current) =>
                    current.transaction != Transaction.empty,
                builder: (context, state) {
                  return TransferItem(transaction: state.transaction);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final Widget child;

  const _Background({
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

class _BackgroundOld extends StatelessWidget {
  final Widget child;

  const _BackgroundOld({
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
        color: AppTheme.generalColorBlue,
        begin: Alignment.topLeft,
        end: Alignment(0.06, 0),
        child: child,
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  TransferItem({
    Key key,
    @required this.transaction,
  })  : _moneyController = MoneyMaskedTextController(precision: 2),
        super(key: key) {
    _moneyController.updateValue(transaction.amount.value);
    amount = _moneyController.text;
  }

  final Transaction transaction;
  final MoneyMaskedTextController _moneyController;
  String amount;

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
                  "to",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Text(
                  "${transaction.targetUser}",
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
        SizedBox(height: getProportionateScreenHeight(28)),
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
                  "the amount of",
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
        SizedBox(height: getProportionateScreenHeight(28)),
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
                  "On the day",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Text(
                  "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
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
