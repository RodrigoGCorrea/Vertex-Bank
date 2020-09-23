import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/logo.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/components/vtx_gradient.dart';

void login() {
  print("ola");
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appBackgroundColor,
      body: Vtx_Gradient(
        begin: Alignment.topLeft,
        color: AppTheme.generalColorBlue,
        child: Vtx_Gradient(
          begin: Alignment.topRight,
          end: Alignment(0.06, 0),
          color: AppTheme.generalColorGreen.withOpacity(0.8),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: Vtx_SizeConfig.screenHeight * 0.2,
                child: Logo(),
              ),
              Positioned(
                top: Vtx_SizeConfig.screenHeight * 0.425,
                width: Vtx_SizeConfig.screenWidth * 0.71,
                height: Vtx_SizeConfig.screenHeight * 0.06,
                child: Vtx_TextBox(
                  text: "User",
                ),
              ),
              Positioned(
                top: Vtx_SizeConfig.screenHeight * 0.514,
                width: Vtx_SizeConfig.screenWidth * 0.71,
                height: Vtx_SizeConfig.screenHeight * 0.06,
                child: Vtx_TextBox(
                  text: "Password",
                  obscureText: true,
                ),
              ),
              Positioned(
                top: Vtx_SizeConfig.screenHeight * 0.65,
                height: Vtx_SizeConfig.screenHeight * 0.058,
                child: Vtx_Button(
                  text: "Login",
                  function: login,
                ),
              ),
              Positioned(
                top: Vtx_SizeConfig.screenHeight * 0.75,
                child: Text(
                  "or",
                  style: TextStyle(color: AppTheme.textColor),
                ),
              ),
              Positioned(
                top: Vtx_SizeConfig.screenHeight * 0.81,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "Create an account",
                    style: TextStyle(color: AppTheme.textColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
