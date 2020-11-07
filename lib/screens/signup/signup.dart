import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/components/signUp/cancel_button.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/cubit/signup/signup_cubit.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSignUpForm(context),
    );
  }

  Widget _buildSignUpForm(BuildContext context) {
    return _Background(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _HeaderSignUp1(),
            SizedBox(height: getProportionateScreenHeight(35)),
            _buildEmailInput(context),
            SizedBox(height: getProportionateScreenHeight(20)),
            _buildPasswordInput(context),
            SizedBox(height: getProportionateScreenHeight(20)),
            _buildPassConfirmationInput(context),
            SizedBox(height: getProportionateScreenHeight(50)),
            _buildNextButton(context),
            SizedBox(height: getProportionateScreenHeight(13)),
            Text(
              "or",
              style: TextStyle(color: AppTheme.textColor),
            ),
            SizedBox(height: getProportionateScreenHeight(25)),
            CancelButton(),
            SizedBox(height: VtxSizeConfig.screenHeight * 0.1)
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: VtxTextBox(
        text: "Email",
        onChangedFunction: (email) =>
            context.bloc<SignupCubit>().emailChanged(email),
      ),
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: VtxTextBox(
        text: "Password",
        obscureText: true,
        onChangedFunction: (pass) =>
            context.bloc<SignupCubit>().passChanged(pass),
      ),
    );
  }

  Widget _buildPassConfirmationInput(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: VtxTextBox(
        text: "Confirm Password",
        obscureText: true,
        onChangedFunction: (pass) =>
            context.bloc<SignupCubit>().passConfirmChanged(pass),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return VtxButton(
      text: "Next",
      function: () => Navigator.of(context).pushNamed('/signup/finish'),
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
      child: VtxGradient(
        begin: Alignment.topLeft,
        color: AppTheme.generalColorBlue,
        child: VtxGradient(
          begin: Alignment.topRight,
          end: Alignment(0.06, 0),
          color: AppTheme.generalColorGreen.withOpacity(0.8),
          child: child,
        ),
      ),
    );
  }
}

class _HeaderSignUp1 extends StatelessWidget {
  const _HeaderSignUp1({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: VtxSizeConfig.screenHeight * 0.1),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.symmetric(horizontal: 42),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello guest, please",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: AppTheme.textColor,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(36),
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}