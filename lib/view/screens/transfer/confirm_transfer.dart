import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';

import 'package:vertexbank/api/transfer.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/vtx_listviewbox.dart';
import 'package:vertexbank/cubit/transfer/action/transfer_action_cubit.dart';
import 'package:vertexbank/cubit/transfer/form/transfer_form_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/models/transaction.dart';

class TransferScreenConfirm extends StatelessWidget {
  const TransferScreenConfirm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TransferActionCubit(transferApi: getIt<TransferApi>()),
      child: Scaffold(
        body: BlocConsumer<TransferActionCubit, TransferActionState>(
          listener: (context, state) {
            if (state is TransferActionCompleted) {
              Navigator.popUntil(context, ModalRoute.withName('/main'));
            } else if (state is TransferActionError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.message),
                ),
              );
            }
          },
          builder: (context, state) {
            // I need to check the completed state, otherwise it will load the
            // old page and then pop out to the main. This makes the transaction
            // between pages more concise
            if (state is TransferActionLoading ||
                state is TransferActionCompleted) {
              return _Background(
                  child: Center(child: CircularProgressIndicator()));
            } else {
              return _Background(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
                      ConfirmTransferAppbar(),
                      SizedBox(height: getProportionateScreenHeight(94)),
                      _ConfirmButton(),
                      SizedBox(height: getProportionateScreenHeight(94)),
                      _CancelButton(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferFormCubit, TransferFormState>(
      builder: (context, state) {
        return VtxButton(
          color: AppTheme.buttonColorGreen,
          text: "Confirm",
          function: () {
            context.read<TransferActionCubit>().completeTransfer(
                  state.transactionSender,
                  state.transactionReceiver,
                );
          },
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VtxButton(
      color: AppTheme.buttonColorRed,
      text: "Cancel",
      function: () {
        Navigator.popUntil(
          context,
          ModalRoute.withName('/main'),
        );
      },
    );
  }
}

class ConfirmTransferAppbar extends StatelessWidget {
  ConfirmTransferAppbar({
    Key key,
  }) : super(key: key);

  final MoneyMaskedTextController _moneyController =
      MoneyMaskedTextController(precision: 2);

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
              listViewBuilder:
                  BlocBuilder<TransferFormCubit, TransferFormState>(
                buildWhen: (previous, current) =>
                    current.transactionSender != Transaction.empty,
                builder: (context, state) {
                  _moneyController.updateValue(state.amount.value);
                  return TransferItem(
                    transaction: state.transactionSender,
                    moneyController: _moneyController,
                  );
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

class TransferItem extends StatelessWidget {
  TransferItem({
    Key key,
    @required this.transaction,
    @required moneyController,
  })  : this.amount = moneyController.text,
        super(key: key);

  final Transaction transaction;
  final String amount;

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
                  "To",
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
                  "The amount of",
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
