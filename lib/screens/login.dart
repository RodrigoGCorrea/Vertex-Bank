import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/logo.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';
import 'package:vertexbank/screens/main_screen.dart';
import 'package:vertexbank/screens/signup1.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    VtxSizeConfig().init(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is UnauthenticatedState) {
          print(state);
          return _buildLoginForm(context);
        } else if (state is AuthenticatedState) {
          return MainScreen();
        } else {
          return Text("[VTX] Error Login Screen");
        }
      },
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Scaffold(
      body: _Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLogo(),
              SizedBox(
                height: getProportionateScreenHeight(45),
              ),
              _buildEmailInput(),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              _buildPasswordInput(),
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

  Widget _buildEmailInput() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: VtxTextBox(
        text: "Email",
        controller: _emailController,
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: VtxTextBox(
        controller: _passwordController,
        obscureText: true,
        text: "Password",
      ),
    );
  }

  void _login(BuildContext context) {
    final authCubit = context.bloc<AuthCubit>();
    authCubit.loginWithEmailPassword(
      _emailController.text,
      _passwordController.text,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return VtxButton(
      text: "Login",
      function: () => _login(context),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUp1(),
          ),
        )
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
