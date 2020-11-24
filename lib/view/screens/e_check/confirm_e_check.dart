import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:vertexbank/api/e_check.dart';
import 'package:vertexbank/cubit/e_check/action/e_check_action_cubit.dart';

import 'package:vertexbank/cubit/e_check/form/e_check_form_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/view/components/background.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/vtx_listviewbox.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/view/screens/e_check/generate_e_check.dart';

class ConfirmECheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ECheckActionCubit(eCheckApi: getIt<ECheckApi>()),
      child: Scaffold(
        body: BlocListener<ECheckActionCubit, ECheckActionState>(
          listener: (context, state) {
            if (state is ECheckActionLoading) {
              EasyLoading.show(status: "Creating your E-Check...");
            } else if (state is ECheckActionFinished) {
              EasyLoading.dismiss();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => GenerateECheckScreen(
                    eCheck: state.eCheck,
                  ),
                ),
                ModalRoute.withName('/main'),
              );
            } else if (state is ECheckActionError) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.error.message);
            }
          },
          child: Background(
            child: Container(
              height: VtxSizeConfig.screenHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: VtxSizeConfig.screenHeight * 0.1),
                child: Column(
                  children: [
                    ConfirmWithdrawAppbar(),
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
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ECheckFormCubit, ECheckFormState>(
      builder: (context, state) => VtxButton(
        text: "Confirm",
        color: AppTheme.buttonColorBlue,
        function: () => context
            .read<ECheckActionCubit>()
            .confirmECheck(state.senderId, state.amount.value),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
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

class ConfirmWithdrawAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(166),
      width: VtxSizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppTheme.defaultHorizontalPadding,
            child: Text(
              "Please confirm this withdraw",
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
              height: getProportionateScreenHeight(70),
              width: getProportionateScreenWidth(285),
              listViewBuilder: BlocBuilder<ECheckFormCubit, ECheckFormState>(
                builder: (context, state) => WithdrawItem(
                  amount: NumberFormat.currency(locale: 'pt_BR', symbol: "")
                      .format(state.amount.value * 0.01),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WithdrawItem extends StatelessWidget {
  const WithdrawItem({
    Key key,
    @required this.amount,
  }) : super(key: key);

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
                color: AppTheme.textColorDark,
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
                    color: AppTheme.textColorDark,
                    fontWeight: AppTheme.generalFontWeight,
                  ),
                ),
                Text(
                  "R\$ $amount",
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
      ],
    );
  }
}
