import "package:flutter/material.dart";
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/components/signUp/cancelButton.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/screens/signup2.dart';

class SignUp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _cpasswordController = TextEditingController();
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderSignUp1(),
              SizedBox(height: getProportionateScreenHeight(35)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(52)),
                child: VtxTextBox(
                  text: "Email",
                  controller: _emailController,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(52)),
                child: VtxTextBox(
                  text: "Password",
                  obscureText: true,
                  controller: _passwordController,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(52)),
                child: VtxTextBox(
                  text: "Confirm Password",
                  obscureText: true,
                  controller: _cpasswordController,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              VtxButton(
                text: "Next",
                function: () => Navigator.of(context).pop(),
              ),
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
              CancelButton(),
              SizedBox(
                height: VtxSizeConfig.screenHeight * 0.1,
              )
            ],
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

class HeaderSignUp1 extends StatelessWidget {
  const HeaderSignUp1({
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
