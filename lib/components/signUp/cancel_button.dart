import 'package:flutter/material.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Text(
        "Cancel",
        style: TextStyle(
          color: AppTheme.textColor,
          fontSize: getProportionateScreenWidth(12),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
