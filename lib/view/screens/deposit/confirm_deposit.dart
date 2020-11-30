import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:vertexbank/api/e_check.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

import 'package:vertexbank/view/components/background.dart';
import 'package:vertexbank/cubit/auth/auth_action_cubit.dart';
import 'package:vertexbank/cubit/deposit/action/confirm/confirm_deposit_action_cubit.dart';
import 'package:vertexbank/cubit/deposit/action/scanner/scanner_deposit_action_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/vtx_listviewbox.dart';

class ConfirmDepositScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        getIt<ScannerDepositActionCubit>().resetState();
        return Future.value(true);
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<ScannerDepositActionCubit>()),
          BlocProvider(
            create: (context) => ConfirmDepositActionCubit(
              eCheckApi: getIt<ECheckApi>(),
            ),
          ),
        ],
        child: Scaffold(
          body: BlocListener<ConfirmDepositActionCubit,
              ConfirmDepositActionState>(
            listener: (context, state) {
              if (state is ConfirmDepositActionLoading) {
                EasyLoading.show(status: "Cashing in E-Check...");
              } else if (state is ConfirmDepositActionError) {
                EasyLoading.dismiss();
                EasyLoading.showError(state.error.message);
              } else if (state is ConfirmDepositActionFinished) {
                EasyLoading.dismiss();
                Navigator.popUntil(context, ModalRoute.withName('/main'));
                context.read<ScannerDepositActionCubit>().resetState();
              }
            },
            child: Background(
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
                          "Please confirm this deposit",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: AppTheme.textColorLight,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        BlocBuilder<ScannerDepositActionCubit,
                            ScannerDepositActionState>(
                          builder: (context, state) {
                            if (state is ScannerDepositActionFinished)
                              return VtxListViewBox(
                                height: getProportionateScreenHeight(190),
                                width: getProportionateScreenWidth(285),
                                listViewBuilder: DepositItem(
                                  name: state.senderName,
                                  amount: NumberFormat.currency(
                                          locale: 'pt_BR', symbol: "")
                                      .format(state.parsedECheck.amount * 0.01),
                                  date: DateTime.now(),
                                ),
                              );
                            else
                              //This should never reach!!
                              return VtxListViewBox(
                                height: getProportionateScreenHeight(190),
                                width: getProportionateScreenWidth(285),
                                listViewBuilder: DepositItem(
                                  name: "",
                                  amount: "",
                                  date: DateTime.now(),
                                ),
                              );
                          },
                        ),
                        Spacer(),
                        _ConfirmButton(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        CancelButton()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerDepositActionCubit, ScannerDepositActionState>(
      builder: (context, state) {
        if (state is ScannerDepositActionFinished)
          return Center(
            child: VtxButton(
              text: "Confirm",
              color: AppTheme.buttonColorBlue,
              function: () =>
                  context.read<ConfirmDepositActionCubit>().confirmDeposit(
                        state.parsedECheck,
                        context
                            .read<AuthActionCubit>()
                            .getSignedInUserWithoutEmit()
                            .id,
                      ),
            ),
          );
        else
          //This should never reach!!
          return Center(
            child: VtxButton(
              text: "Confirm",
              color: AppTheme.buttonColorBlue,
            ),
          );
      },
    );
  }
}

class DepositItem extends StatelessWidget {
  DepositItem({
    Key key,
    @required this.name,
    @required this.amount,
    @required this.date,
  }) : super(key: key);

  final String name;
  final String amount;
  final DateTime date;

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
                color: AppTheme.textColorDark,
                width: getProportionateScreenWidth(4),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "From",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: AppTheme.textColorDark,
                      fontWeight: AppTheme.generalFontWeight,
                    ),
                  ),
                  Text(
                    name,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColorDark,
                    ),
                  ),
                ],
              ),
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
                color: AppTheme.textColorDark,
                width: getProportionateScreenWidth(4),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "The amount of",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: AppTheme.textColorDark,
                      fontWeight: AppTheme.generalFontWeight,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "R\$$amount",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColorDark,
                      ),
                    ),
                  ),
                ],
              ),
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
                color: AppTheme.textColorDark,
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
                  "${date.day}/${date.month}/${date.year}",
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

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: VtxButton(
        color: AppTheme.buttonColorRed,
        text: "Cancel",
        function: () {
          Navigator.popUntil(
            context,
            ModalRoute.withName('/main'),
          );
          context.read<ScannerDepositActionCubit>().resetState();
        },
      ),
    );
  }
}
