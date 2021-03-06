import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

import 'package:vertexbank/view/components/vtx_listviewbox.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<Widget> list;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VtxListViewBox(
          width: getProportionateScreenWidth(285),
          height: getProportionateScreenHeight(255),
          listViewBuilder: ListView.builder(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(16)),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return list[index];
            },
          ),
        ),
      ],
    );
  }
}

class VtxTransactionItem extends StatelessWidget {
  final String amount;
  final String userName;
  final DateTime date;
  final bool received;
  final String ftfield;
  final String sign;
  final Color transactionColor;

  const VtxTransactionItem({
    Key key,
    @required this.amount,
    @required this.userName,
    @required this.date,
    @required this.received,
  })  : ftfield = received ? "From" : "To",
        sign = received ? "+" : "-",
        transactionColor =
            received ? AppTheme.buttonColorBlue : AppTheme.buttonColorRed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(4)),
            child: SvgPicture.asset(
              "assets/icons/circle-solid.svg",
              color: AppTheme.buttonColorBlue,
              width: getProportionateScreenWidth(4),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(6)),
          Container(
            width: getProportionateScreenWidth(29),
            child: Text(
              ftfield,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(11),
                fontWeight: FontWeight.w300,
                color: AppTheme.textColorDark,
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(8)),
          Container(
            width: VtxSizeConfig.screenWidth * 0.28,
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$userName",
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(11),
                      fontWeight: FontWeight.w300,
                      color: AppTheme.textColorDark,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "$sign$amount R\$",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(11),
                        fontWeight: FontWeight.bold,
                        color: transactionColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(6),
                right: getProportionateScreenWidth(5)),
            child: Text(
              "${date.day}/${date.month}/${date.year}",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(9),
                fontWeight: FontWeight.w300,
                color: AppTheme.textColorDark,
              ),
            ),
          )
        ],
      ),
    );
  }
}
