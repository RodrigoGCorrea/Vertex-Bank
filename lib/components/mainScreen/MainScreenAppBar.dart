import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vertexbank/assets/apptheme.dart';

class MainScreenAppBar extends StatelessWidget {
  const MainScreenAppBar({
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
              fontSize: 16,
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
                onPressed: () => print("Fazer menu configurações"),
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
}
