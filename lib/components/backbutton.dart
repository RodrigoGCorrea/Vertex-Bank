import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

class VtxBackButton extends StatelessWidget {
  const VtxBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(72),
      child: FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/chevron-left-solid.svg",
              width: getProportionateScreenWidth(10),
              color: AppTheme.textColor,
            ),
            SizedBox(
              width: getProportionateScreenWidth(4),
            ),
            Text(
              "back",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(10),
                color: AppTheme.textColor,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
