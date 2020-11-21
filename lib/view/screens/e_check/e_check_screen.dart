import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:vertexbank/api/money.dart';
import 'package:vertexbank/cubit/auth/auth_action_cubit.dart';
import 'package:vertexbank/cubit/e_check/form/e_check_form_cubit.dart';
import 'package:vertexbank/cubit/money/money_watcher_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/view/screens/e_check/confirm_e_check.dart';

class ECheckScreen extends StatefulWidget {
  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<ECheckScreen> {
  final eCheckFormCubit = ECheckFormCubit();

  final MoneyMaskedTextController moneyController =
      MoneyMaskedTextController(precision: 2);

  @override
  void dispose() {
    eCheckFormCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: eCheckFormCubit
              ..setUserInfo(
                context.watch<AuthActionCubit>().getSignedInUserWithoutEmit(),
              )),
        BlocProvider<MoneyWatcherCubit>(
          create: (context) => MoneyWatcherCubit(moneyApi: getIt<MoneyApi>())
            ..setMoneyWatcher(
              context.read<AuthActionCubit>().getSignedInUserWithoutEmit().id,
            ),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Scaffold(
          body: Background(
            child: Container(
              height: VtxSizeConfig.screenHeight,
              child: Column(
                children: [
                  SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
                  BlocListener<MoneyWatcherCubit, MoneyWatcherState>(
                    //Yeah... This is to force the listener to run when this screen is opened.
                    //If you, dear reader, know anything better let me know. Thanks.
                    listenWhen: (previous, current) =>
                        previous == current || previous != current,
                    listener: (context, state) {
                      context
                          .read<ECheckFormCubit>()
                          .updateUserMoney(state.money);
                    },
                    child: BlocBuilder<ECheckFormCubit, ECheckFormState>(
                        builder: (context, state) {
                      return WithdrawScreenAppbar(
                        moneyController: moneyController,
                        functionChanged: (_) => context
                            .read<ECheckFormCubit>()
                            .amountInputChanged(
                                amountDouble: moneyController.numberValue),
                        errorText: !state.amount.isValid &&
                                state.stage != ECheckFormStage.initial
                            ? state.amount.errorText
                            : null,
                      );
                    }),
                  ),
                  Spacer(),
                  _NextButton(
                    eCheckFormCubit: eCheckFormCubit,
                  ),
                  SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    Key key,
    @required this.eCheckFormCubit,
  }) : super(key: key);

  final ECheckFormCubit eCheckFormCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ECheckFormCubit, ECheckFormState>(
      builder: (context, state) {
        final bool isFormValid = state.amount.isValid;
        if (isFormValid) {
          return VtxButton(
            text: "Next",
            color: AppTheme.buttonColorGreen,
            function: () {
              context.read<ECheckFormCubit>().setECheckFormSelected();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                      value: eCheckFormCubit, child: ConfirmECheckScreen()),
                ),
              );
            },
          );
        } else {
          return VtxButton(
              text: "Next",
              color: AppTheme.buttonColorGreen,
              function: () {
                context.read<ECheckFormCubit>().setECheckFormSelected();
              });
        }
      },
    );
  }
}

class WithdrawScreenAppbar extends StatelessWidget {
  const WithdrawScreenAppbar({
    Key key,
    @required this.functionChanged,
    @required this.moneyController,
    @required this.errorText,
  }) : super(key: key);

  final Function(String amount) functionChanged;
  final MoneyMaskedTextController moneyController;
  final String errorText;

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
              "Amount to withdraw",
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
                    //NOTE(Geraldo): Correa, tu que fez o texto não dar overflow,
                    //               não foi o controller não. Olha esse Flexible ai
                    Flexible(
                      child: TextField(
                        onChanged: functionChanged,
                        controller: moneyController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(24),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor,
                        ),
                        decoration: InputDecoration(
                          errorText: errorText,
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
