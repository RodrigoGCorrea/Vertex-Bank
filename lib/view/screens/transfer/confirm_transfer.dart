import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:vertexbank/api/transfer.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/view/components/background.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/vtx_listviewbox.dart';
import 'package:vertexbank/cubit/transfer/action/transfer/transfer_action_cubit.dart';
import 'package:vertexbank/cubit/transfer/form/transfer/transfer_form_cubit.dart';
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
        body: BlocListener<TransferActionCubit, TransferActionState>(
          listener: (context, state) {
            if (state is TransferActionLoading) {
              EasyLoading.show(status: "Making paymente...");
            } else if (state is TransferActionCompleted) {
              EasyLoading.dismiss();
              Navigator.popUntil(context, ModalRoute.withName('/main'));
            } else if (state is TransferActionError) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.error.message);
            }
          },
          child: Background(
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
          ),
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
          color: AppTheme.buttonColorBlue,
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
                color: AppTheme.textColorLight,
                fontWeight: AppTheme.generalFontWeight,
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
                  return TransferItem(
                    amount:
                        NumberFormat.currency(locale: 'pt_BR', symbol: "R\$")
                            .format(state.amount.value * 0.01),
                    transaction: state.transactionSender,
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

class TransferItem extends StatelessWidget {
  const TransferItem({
    Key key,
    @required this.transaction,
    @required this.amount,
  }) : super(key: key);

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
                  "to",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: AppTheme.textColorDark,
                    fontWeight: AppTheme.generalFontWeight,
                  ),
                ),
                Text(
                  "${transaction.targetUser}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColorDark,
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
                    color: AppTheme.textColorDark,
                    fontWeight: AppTheme.generalFontWeight,
                  ),
                ),
                Text(
                  "$amount",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColorDark,
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
                    color: AppTheme.textColorDark,
                    fontWeight: AppTheme.generalFontWeight,
                  ),
                ),
                Text(
                  "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColorDark,
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
