import 'package:flutter/material.dart';
import 'package:vertexbank/assets/apptheme.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: FlatButton(
        onPressed: () {},
        child: Text(
          "Login",
          style: TextStyle(
            color: AppTheme.textColor,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Colors.green,
      ),
    );
  }
}
