import 'package:flutter/material.dart';
import 'package:vertexbank/config/size_config.dart';

import '../vtx_icon_button.dart';

class VtxButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(38),
      ),
      child: Row(
        children: [
          VtxIconButton(
            iconPath: "assets/icons/handshake-solid.svg",
            text: "Pay",
            width: getProportionateScreenHeight(75),
            height: getProportionateScreenHeight(70),
            function: () => Navigator.of(context).pushNamed('/transfer'),
          ),
          Spacer(),
          VtxIconButton(
            iconPath: "assets/icons/money-bill-solid.svg",
            text: "Deposit",
            width: getProportionateScreenHeight(75),
            height: getProportionateScreenHeight(70),
            function: () => Navigator.of(context).pushNamed('/deposit'),
          ),
          Spacer(),
          VtxIconButton(
            iconPath: "assets/icons/hand-holding-usd-solid.svg",
            text: "Withdraw",
            width: getProportionateScreenHeight(75),
            height: getProportionateScreenHeight(70),
            function: () => Navigator.of(context).pushNamed('/withdraw'),
          ),
        ],
      ),
    );
  }
}
