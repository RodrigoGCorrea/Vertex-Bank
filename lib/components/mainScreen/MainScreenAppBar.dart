import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/screens/login.dart';

class MainScreenAppBar extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MainScreenAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.defaultHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back,",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: AppTheme.textColor,
              fontWeight: FontWeight.w100,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jorge Dorival",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              IconButton(
                onPressed: () => signOut(context),
                icon: SvgPicture.asset(
                  "assets/icons/cog-solid.svg",
                  color: AppTheme.textColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void signOut(context) {
    _auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
