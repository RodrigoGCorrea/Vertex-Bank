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
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: Vtx_SizeConfig.screenHeight * 0.2,
              child: Logo(),
              // child: Padding(
              //   padding: EdgeInsets.only(top: Vtx_SizeConfig.screenHeight * 0.2),
              // ),
            ),
            Positioned(
              top: Vtx_SizeConfig.screenHeight * 0.425,
              width: Vtx_SizeConfig.screenWidth * 0.71,
              height: Vtx_SizeConfig.screenWidth * 0.12,
              child: Vtx_TextBox(
                text: "Usuário",
              ),
            ),
            Positioned(
              top: Vtx_SizeConfig.screenHeight * 0.514,
              width: Vtx_SizeConfig.screenWidth * 0.71,
              height: Vtx_SizeConfig.screenWidth * 0.12,
              child: Vtx_TextBox(
                text: "Senha",
                obscureText: true,
              ),
            ),
            Positioned(
              top: Vtx_SizeConfig.screenHeight * 0.65,
              height: Vtx_SizeConfig.screenWidth * 0.12,
              child: Vtx_Button(text: "Login")
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
    );
  }
}
