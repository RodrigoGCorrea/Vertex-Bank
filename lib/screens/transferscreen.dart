import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/transferscreen/transferscreenappbar.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/components/vtxlistviewbox.dart';
import 'package:vertexbank/models/Contact.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _moneyController = MoneyMaskedTextController();
    List<Widget> contactList = [
      ContactListItem(
        contact: Contact("FDP Corp."),
      ),
    ];
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
            TransferScreenAppBar(controller: _moneyController),
            SizedBox(height: getProportionateScreenHeight(30)),
            ContactList(contactList: contactList)
          ],
        ),
      ),
    );
  }
}

class ContactList extends StatefulWidget {
  ContactList({
    Key key,
    @required this.contactList,
  }) : super(key: key);

  List<Widget> contactList;

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.defaultHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Paying to",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: AppTheme.textColor,
              fontWeight: FontWeight.w100,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Stack(
            children: [
              VtxListViewBox(
                list: widget.contactList,
                width: getProportionateScreenWidth(285),
                height: getProportionateScreenHeight(140),
              ),
              Positioned(
                right: getProportionateScreenWidth(6),
                top: getProportionateScreenHeight(55),
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
          )
        ],
      ),
    );
  }
}

class ContactListItem extends StatelessWidget {
  final Contact contact;

  const ContactListItem({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(22)),
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
          Text(
            "${contact.nickname}",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(14),
              color: AppTheme.textColor,
              fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: VtxSizeConfig.screenWidth,
      height: VtxSizeConfig.screenHeight,
      color: AppTheme.appBackgroundColor,
      child: VtxGradient(
        color: AppTheme.generalColorBlue,
        begin: Alignment.topRight,
        end: Alignment(0.06, 0),
        child: child,
      ),
    );
  }
}
