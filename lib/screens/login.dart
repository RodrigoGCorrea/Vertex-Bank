import 'package:flutter/material.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/login/loginbutton.dart';
import 'package:vertexbank/components/login/logo.dart';
import 'package:vertexbank/components/login/textbox.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Vtx_SizeConfig.widthMultiplier * 7.77) ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: Vtx_SizeConfig.screenHeight * 0.2),
                child: Logo(),
              ),
              Padding(
                padding: EdgeInsets.only(top: Vtx_SizeConfig.screenHeight * 0.1),
                child: Vtx_TextBox(
                  text: "Usuário",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Vtx_SizeConfig.screenHeight * 0.035),
                child: Vtx_TextBox(
                  text: "Senha",
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Vtx_SizeConfig.screenHeight * 0.1),
                child: Vtx_Button(text: "Login"),
              ),
              Padding(
                padding: EdgeInsets.only(top: Vtx_SizeConfig.screenHeight * 0.035),
                child: Text(
                  "or",
                  style: TextStyle(color: AppTheme.textColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Vtx_SizeConfig.screenHeight * 0.035),
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
