import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/view/components/background.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/login/logo.dart';
import 'package:vertexbank/view/components/login/textbox.dart';

import 'package:vertexbank/cubit/auth/auth_action_cubit.dart';

import 'package:vertexbank/cubit/login/login_form_cubit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VtxSizeConfig().init(context);

    return BlocProvider(
      create: (context) => LoginFormCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Scaffold(
          body: BlocListener<AuthActionCubit, AuthActionState>(
            listener: (context, state) {
              if (state is AuthActionLoading) {
                EasyLoading.show(status: "Log in...");
              } else if (state is AuthActionAuthenticated) {
                EasyLoading.dismiss();
                Navigator.pushReplacementNamed(context, "/main");
              } else if (state is AuthActionError) {
                EasyLoading.dismiss();
                EasyLoading.showError(state.error.message);
              }
            },
            child: Background(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildLogo(),
                    SizedBox(height: getProportionateScreenHeight(45)),
                    _buildEmailInput(context),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    _buildPasswordInput(context),
                    SizedBox(height: getProportionateScreenHeight(45)),
                    _buildLoginButton(context),
                    SizedBox(height: getProportionateScreenHeight(13)),
                    Text(
                      "or",
                      style: TextStyle(color: AppTheme.textColorLight),
                    ),
                    SizedBox(height: getProportionateScreenHeight(25)),
                    _buildSignUpButton(context),
                    SizedBox(height: VtxSizeConfig.screenHeight * 0.1)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: EdgeInsets.only(top: VtxSizeConfig.screenHeight * 0.2),
      child: Logo(),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      buildWhen: (previous, current) =>
          previous.email != current.email || previous.stage != current.stage,
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
          child: VtxTextBox(
            text: "Email",
            onChangedFunction: (email) =>
                context.read<LoginFormCubit>().emailChanged(email),
            errorText: !state.email.isValid && state.stage == LoginStage.sent
                ? state.email.errorText
                : null,
          ),
        );
      },
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.stage != current.stage,
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
          child: VtxTextBox(
            obscureText: true,
            text: "Password",
            onChangedFunction: (password) =>
                context.read<LoginFormCubit>().passwordChanged(password),
            errorText: !state.password.isValid && state.stage == LoginStage.sent
                ? state.password.errorText
                : null,
          ),
        );
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      builder: (context, state) {
        final bool isFormValid = state.email.isValid & state.password.isValid;

        if (isFormValid) {
          return VtxButton(
            text: "Login",
            function: () {
              context
                  .read<AuthActionCubit>()
                  .logIn(state.email.value, state.password.value);
            },
          );
        } else {
          return VtxButton(
            text: "Login",
            function: () =>
                context.read<LoginFormCubit>().setLoginFormAndRefresh(),
          );
        }
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.pushNamed(context, '/signup'),
      },
      child: Text(
        "Create an account",
        style: TextStyle(
          color: AppTheme.textColorLight,
          fontSize: getProportionateScreenWidth(12),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
