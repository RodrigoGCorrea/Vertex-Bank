import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/logo.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';
import 'package:vertexbank/cubit/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //NOTE(Geraldo): Se uma tela for carregada antes do Login o size config vai dar merda,
    //               esse é único lugar que a chama o init dele.
    VtxSizeConfig().init(context);

    return Scaffold(
      body: _Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLogo(),
              SizedBox(
                height: getProportionateScreenHeight(45),
              ),
              _buildEmailInput(context),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              _buildPasswordInput(context),
              SizedBox(
                height: getProportionateScreenHeight(45),
              ),
              _buildLoginButton(context),
              SizedBox(
                height: getProportionateScreenHeight(13),
              ),
              Text(
                "or",
                style: TextStyle(color: AppTheme.textColor),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              _buildSignUpButton(context),
              SizedBox(
                height: VtxSizeConfig.screenHeight * 0.1,
              )
            ],
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
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.email.value != current.email.value &&
            previous.stage != current.stage;
      },
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
          child: VtxTextBox(
            text: "Email",
            onChangedFunction: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            errorText: !state.email.isValid && state.stage == LoginStage.sent
                ? state.email.errorText
                : null,
          ),
        );
      },
    );
  }

  Widget _buildPasswordInput(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.password.value != current.password.value &&
            previous.stage != current.stage;
      },
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
          child: VtxTextBox(
            obscureText: true,
            text: "Password",
            onChangedFunction: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            errorText: !state.password.isValid && state.stage == LoginStage.sent
                ? state.password.errorText
                : null,
          ),
        );
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.of(context).pushNamed('/');
        } else if (state is ErrorState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
            ),
          );
        }
      },
      child: VtxButton(
        text: "Login",
        function: () => context.read<LoginCubit>().finishLogin(),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.of(context).pushNamed('/signup'),
      },
      child: Text(
        "Create an account",
        style: TextStyle(
          color: AppTheme.textColor,
          fontSize: getProportionateScreenWidth(12),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

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
