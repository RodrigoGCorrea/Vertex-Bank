import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class MainScreenAppBar extends StatelessWidget {
  const MainScreenAppBar({
    @required this.userName,
    @required this.configFunction,
    Key key,
  }) : super(key: key);

  final String userName;
  final Function configFunction;

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
              color: AppTheme.textColorLight,
              fontWeight: AppTheme.generalFontWeight,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(36),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColorLight,
                ),
              ),
              IconButton(
                onPressed: configFunction,
                icon: SvgPicture.asset(
                  "assets/icons/Sign-out-02.svg",
                  color: AppTheme.textColorLight,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
