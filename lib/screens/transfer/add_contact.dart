import 'package:flutter/material.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/login/textbox.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class AddContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: SingleChildScrollView(
            child: Container(
              height: VtxSizeConfig.screenHeight,
              child: Column(
                children: [
                  HeaderAddContact(),
                  SizedBox(height: getProportionateScreenHeight(35)),
                  NicknameInput(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  ContactIdInput(),
                  Spacer(),
                  VtxButton(
                    text: "Finish",
                    color: AppTheme.buttonColorGreen,
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
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: getProportionateScreenWidth(12),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: VtxSizeConfig.screenHeight * 0.1)
                ],
              ),
            ),
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
      child: child,
    );
  }
}

class HeaderAddContact extends StatelessWidget {
  const HeaderAddContact({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: VtxSizeConfig.screenHeight * 0.1),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.symmetric(horizontal: 42),
        child: Text(
          "Add new contact",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(24),
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
      ),
    );
  }
}

class NicknameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: VtxTextBox(text: "Nickname"),
    );
  }
}

class ContactIdInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(52)),
      child: VtxTextBox(text: "Contact ID"),
    );
  }
}
