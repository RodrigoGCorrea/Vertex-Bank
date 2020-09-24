import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/logo.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/components/vtx_gradient.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appBackgroundColor,
      body: VtxGradient(
        begin: Alignment.topLeft,
        color: AppTheme.generalColorBlue,
        child: VtxGradient(
          begin: Alignment.topRight,
          end: Alignment(0.06, 0),
          color: AppTheme.generalColorGreen.withOpacity(0.8),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: VtxSizeConfig.screenHeight * 0.2,
                child: Logo(),
              ),
              Positioned(
                top: VtxSizeConfig.screenHeight * 0.425,
                width: VtxSizeConfig.screenWidth * 0.71,
                height: VtxSizeConfig.screenHeight * 0.06,
                child: VtxTextBox(
                  text: "User",
                ),
              ),
              Positioned(
                top: VtxSizeConfig.screenHeight * 0.514,
                width: VtxSizeConfig.screenWidth * 0.71,
                height: VtxSizeConfig.screenHeight * 0.06,
                child: VtxTextBox(
                  text: "Password",
                  obscureText: true,
                ),
              ),
              Positioned(
                top: VtxSizeConfig.screenHeight * 0.65,
                height: VtxSizeConfig.screenHeight * 0.058,
                child: VtxButton(
                  text: "Login",
                  function: signIn,
                ),
              ),
              Positioned(
                top: VtxSizeConfig.screenHeight * 0.75,
                child: Text(
                  "or",
                  style: TextStyle(color: AppTheme.textColor),
                ),
              ),
              Positioned(
                top: VtxSizeConfig.screenHeight * 0.81,
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

  void signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: "qissocara@gmail.com",
        password: "caraiborracha",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    _auth.authStateChanges().listen(
      (User user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      },
    );
  }
}
