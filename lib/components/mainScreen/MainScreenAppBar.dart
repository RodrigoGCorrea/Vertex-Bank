import 'package:flutter/material.dart';
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
              fontSize: 14,
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
                  color: AppTheme.textColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  size: 36,
                  color: AppTheme.textColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
