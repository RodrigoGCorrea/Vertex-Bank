import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/cubit/cubit/contactlist_cubit.dart';
import 'package:vertexbank/cubit/transferscreen/contactListBloc.dart';
import 'package:vertexbank/models/Contact.dart';

import '../vtxlistviewbox.dart';

class ContactList extends StatefulWidget {
  List<ContactListItem> contactList;
  ContactList({
    Key key,
    this.contactList,
  }) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    context.bloc<ContactlistCubit>().setContactList(widget.contactList);
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
                width: getProportionateScreenWidth(285),
                height: getProportionateScreenHeight(140),
                listViewBuilder:
                    BlocBuilder<ContactlistCubit, ContactlistState>(
                  builder: (context, state) {
                    if (state is ContactlistInitial) {
                      return ListView.builder(
                        padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(16),
                        ),
                        itemCount: state.contactList.length,
                        itemBuilder: (BuildContext context, int i) {
                          return GestureDetector(
                            onTap: () => context
                                .bloc<ContactlistCubit>()
                                .selectContact(i),
                            child: state.contactList[i],
                          );
                        },
                      );
                    }
                    return Text("Error");
                  },
                ),
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

class ContactListItem extends StatefulWidget {
  final Contact contact;
  bool isSelected;
  Color color;

  ContactListItem({
    Key key,
    this.contact,
  }) : super(key: key) {
    if (isSelected == null) isSelected = false;
    if (color == null) color = AppTheme.textColor;
  }

  @override
  _ContactListItemState createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
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
          BlocBuilder<ContactlistCubit, ContactlistState>(
            builder: (context, state) {
              widget.isSelected
                  ? widget.color = AppTheme.buttonColorGreen
                  : widget.color = AppTheme.textColor;
              return Text(
                "${widget.contact.nickname}",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: widget.color,
                  fontWeight: FontWeight.w100,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
