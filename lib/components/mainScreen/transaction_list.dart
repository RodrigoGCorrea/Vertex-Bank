import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/models/transaction.dart';

import 'package:vertexbank/components/vtx_listviewbox.dart';

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
          height: getProportionateScreenHeight(187),
          listViewBuilder: ListView.builder(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(16)),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return list[index];
            },
          ),
        ),
        Positioned(
          right: getProportionateScreenWidth(7),
          top: getProportionateScreenHeight(80),
          child: Container(
            width: getProportionateScreenWidth(31),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/chevron-right-solid.svg",
                  width: getProportionateScreenWidth(13),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  "More",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(11),
                    color: AppTheme.textColor,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class VtxTransactionItem extends StatelessWidget {
  final Transaction transaction;
  final amount;
  String ftfield;
  String sign;
  Color transactionColor;

  VtxTransactionItem({
    Key key,
    @required this.transaction,
  })  : amount = transaction.amount.value.toString(),
        super(key: key) {
    transaction.received ? ftfield = "From" : ftfield = "To";
    transaction.received ? sign = "+" : sign = "-";
    transaction.received
        ? transactionColor = AppTheme.buttonColorGreen
        : transactionColor = AppTheme.buttonColorRed;
  }

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
                color: AppTheme.textColor,
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(8)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${transaction.targetUser}",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(11),
                  fontWeight: FontWeight.w300,
                  color: AppTheme.textColor,
                ),
              ),
              Text(
                "$sign$amount R\$",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(11),
                  fontWeight: FontWeight.bold,
                  color: transactionColor,
                ),
              )
            ],
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(6),
                right: getProportionateScreenWidth(5)),
            child: Text(
              "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(9),
                fontWeight: FontWeight.w300,
                color: AppTheme.textColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
