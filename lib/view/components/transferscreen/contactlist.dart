import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/cubit/transfer/form/transfer/transfer_form_cubit.dart';
import 'package:vertexbank/models/contact.dart';
import 'package:vertexbank/view/components/vtx_listviewbox.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key key}) : super(key: key);

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
              color: AppTheme.textColorLight,
              fontWeight: AppTheme.generalFontWeight,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          Stack(
            children: [
              //TODO(Geraldo): Adicionar algum campo de erro no VtxListViewBox
              VtxListViewBox(
                width: getProportionateScreenWidth(285),
                height: getProportionateScreenHeight(140),
                listViewBuilder:
                    BlocBuilder<TransferFormCubit, TransferFormState>(
                  builder: (context, state) {
                    if (state.contactList.length <= 0) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "You don't have any contacts added...",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                              color: AppTheme.textColorDark,
                              fontWeight: AppTheme.generalFontWeight,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(16),
                        ),
                        itemCount: state.contactList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => context
                                .read<TransferFormCubit>()
                                .selectContact(index),
                            child: ContactListItem(
                              contact: state.contactList[index],
                              isSelected:
                                  state.indexContactListSelected.value == index
                                      ? true
                                      : false,
                            ),
                          );
                        },
                      );
                    }
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
                          color: AppTheme.textColorDark,
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
  const ContactListItem({
    @required this.contact,
    @required this.isSelected,
    Key key,
  })  : this.isBold = isSelected ? FontWeight.bold : FontWeight.w300,
        super(key: key);

  final Contact contact;
  final bool isSelected;
  final FontWeight isBold;

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
          Text(
            "${contact.nickname}",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(14),
              color: AppTheme.textColorDark,
              fontWeight: isBold,
            ),
          ),
        ],
      ),
    );
  }
}
