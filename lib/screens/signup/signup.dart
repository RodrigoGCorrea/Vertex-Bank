import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/components/signUp/cancel_button.dart';
import 'package:vertexbank/cubit/signup/signup_form_cubit.dart';
import 'package:vertexbank/screens/signup/signup_finish.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  _SignUpScreenState() : super();

  final signUpCubit = SignUpFormCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: signUpCubit,
      child: Scaffold(
        body: _buildSignUpForm(context),
      ),
    );
  }

  @override
  void dispose() {
    signUpCubit.close();
    super.dispose();
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
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) =>
          previous.email != current.email || previous.stage != current.stage,
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
          child: VtxTextBox(
            text: "Email",
            onChangedFunction: (email) =>
                context.read<SignUpFormCubit>().emailChanged(email),
            errorText: !state.email.isValid && state.stage != SignUpStage.intial
                ? state.email.errorText
                : null,
          ),
        );
      },
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.stage != current.stage,
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
          child: VtxTextBox(
            text: "Password",
            obscureText: true,
            onChangedFunction: (pass) =>
                context.read<SignUpFormCubit>().passwordChanged(pass),
            errorText:
                !state.password.isValid && state.stage != SignUpStage.intial
                    ? state.password.errorText
                    : null,
          ),
        );
      },
    );
  }

  Widget _buildPassConfirmationInput(BuildContext context) {
    return BlocConsumer<SignUpFormCubit, SignUpFormState>(
      listenWhen: (previous, current) => previous.password != current.password,
      listener: (context, state) => {
        context
            .read<SignUpFormCubit>()
            .passwordConfirmChanged(state.confirmPassword.value)
      },
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmPassword != current.confirmPassword ||
          previous.stage != current.stage,
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
          child: VtxTextBox(
            text: "Confirm Password",
            obscureText: true,
            onChangedFunction: (pass) =>
                context.read<SignUpFormCubit>().passwordConfirmChanged(pass),
            errorText: !state.confirmPassword.isValid &&
                    state.stage != SignUpStage.intial
                ? state.confirmPassword.errorText
                : null,
          ),
        );
      },
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      builder: (context, state) {
        final bool isFormValid = state.email.isValid &
            state.password.isValid &
            state.confirmPassword.isValid;
        if (isFormValid)
          return VtxButton(
            text: "Next",
            function: () {
              context.read<SignUpFormCubit>().setSignUpFormNextAndRefresh();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: signUpCubit,
                    child: SignUpFinishScreen(),
                  ),
                ),
              );
            },
          );
        else
          return VtxButton(
            text: "Next",
            function: () =>
                context.read<SignUpFormCubit>().setSignUpFormNextAndRefresh(),
          );
      },
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
