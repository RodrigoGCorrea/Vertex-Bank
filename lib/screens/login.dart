import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/logo.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    VtxSizeConfig().init(context);
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: VtxSizeConfig.screenHeight * 0.2),
                child: Logo(),
              ),
              SizedBox(
                height: getProportionateScreenHeight(45),
              ),
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
                  controller: _passwordController,
                  obscureText: true,
                  text: "Password",
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(45),
              ),
              VtxButton(
                text: "Login",
                function: signIn,
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
              InkWell(
                onTap: () => _auth.signOut(),
                child: Text(
                  "Create an account",
                  style: TextStyle(
                    color: AppTheme.textColor,
                    fontSize: getProportionateScreenWidth(12),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: VtxSizeConfig.screenHeight * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ),
          );
        }
      },
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
