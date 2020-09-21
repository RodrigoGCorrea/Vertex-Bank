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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.appBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.2),
              child: Logo(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 50, 8, 10),
              child: Textbox(
                text: "Usuário",
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
              child: Textbox(
                text: "Senha",
                obscureText: true,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40),
              child: LoginButton(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "or",
                style: TextStyle(color: AppTheme.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
