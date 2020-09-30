import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/models/transaction.dart';

class TransactionList extends StatefulWidget {
  TransactionList({
    Key key,
  }) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<Widget> transactionList = <Widget>[
    VtxTransactionItem(
      transaction: Transaction(
        name: "FDP Corp.",
        received: true,
        amount: "1903,40",
        date: DateTime.now(),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(285),
      height: getProportionateScreenHeight(187),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TransactionListBackground(),
          Positioned(
            width: getProportionateScreenWidth(211),
            height: getProportionateScreenHeight(187),
            child: ListView.builder(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(16)),
              itemCount: transactionList.length,
              itemBuilder: (BuildContext context, int index) {
                return transactionList[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionListBackground extends StatelessWidget {
  const TransactionListBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(285),
      height: getProportionateScreenHeight(187),
      decoration: AppTheme.vtxBuildBoxDecoration(),
      child: Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: getProportionateScreenWidth(31),
          ),
          VerticalDivider(
            color: AppTheme.textColor,
            thickness: 1.5,
          ),
          SizedBox(
            width: getProportionateScreenWidth(204),
            height: double.infinity,
          ),
          Container(
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
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class VtxTransactionItem extends StatelessWidget {
  final Transaction transaction;
  String ftfield;
  String sign;
  Color transactionColor;

  VtxTransactionItem({
    Key key,
    @required this.transaction,
  }) : super(key: key) {
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
                "${transaction.name}",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(11),
                  fontWeight: FontWeight.w300,
                  color: AppTheme.textColor,
                ),
              ),
              Text(
                "$sign${transaction.amount} R\$",
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
