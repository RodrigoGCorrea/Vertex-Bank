import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/cubit/deposit/action/scanner/scanner_deposit_action_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/screens/deposit/confirm_deposit.dart';
import 'package:vertexbank/view/screens/deposit/scan.dart';

class DepositScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ScannerDepositActionCubit>(),
      child: Scaffold(
        body: Background(
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
                      "Scan QR-Code",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(35)),
                    ScanButton(
                      function: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scan(),
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Center(
                      child: Text(
                        "or",
                        style: TextStyle(color: AppTheme.textColor),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    SelectFromFiles(),
                    Spacer(),
                    _NextButton()
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

class _NextButton extends StatelessWidget {
  const _NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ScannerDepositActionCubit, ScannerDepositActionState>(
          builder: (context, state) {
        if (state is ScannerDepositActionFinished)
          return VtxButton(
            text: "Next",
            function: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmDeposit(),
              ),
            ),
          );
        else
          return VtxButton(
            text: "Next",
            function: () {},
          );
      }),
    );
  }
}

class SelectFromFiles extends StatelessWidget {
  final Function function;

  const SelectFromFiles({
    Key key,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: function,
        child: Text(
          "Select QR-Code from files",
          style: TextStyle(
            color: AppTheme.textColor,
            fontSize: getProportionateScreenWidth(12),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class ScanButton extends StatelessWidget {
  final Function function;

  const ScanButton({
    Key key,
    @required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: getProportionateScreenHeight(153),
        height: getProportionateScreenHeight(153),
        decoration: BoxDecoration(
          color: AppTheme.buttonColorGreen,
          borderRadius: BorderRadius.circular(15),
        ),
        child: FlatButton(
          onPressed: function,
          child: SvgPicture.asset(
            "assets/icons/qrcode-solid.svg",
            width: double.infinity,
            color: AppTheme.textColor,
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
