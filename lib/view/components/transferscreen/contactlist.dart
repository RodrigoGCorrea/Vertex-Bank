import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertexbank/api/contact.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/cubit/auth/auth_action_cubit.dart';
import 'package:vertexbank/cubit/contact/watcher/contact_list_watcher_cubit.dart';
import 'package:vertexbank/cubit/transfer/form/transfer_form_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/models/contact.dart';
import 'package:vertexbank/view/components/vtx_listviewbox.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactListWatcherCubit>(
      create: (context) => ContactListWatcherCubit(
          contactApi: getIt<ContactApi>())
        ..setContactListWatcher(
            context.read<AuthActionCubit>().getSignedInUserWithoutEmit().id),
      child: Container(
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
                VtxListViewBox(
                  width: getProportionateScreenWidth(285),
                  height: getProportionateScreenHeight(205),
                  listViewBuilder: BlocConsumer<ContactListWatcherCubit,
                      ContactListWatcherState>(
                    listener: (context, state) {
                      if (state is ContactListWatcherFinished) {
                        context
                            .read<TransferFormCubit>()
                            .updateContactList(state.contactList);
                      }
                    },
                    builder: (context, state) {
                      if (state is ContactListWatcherFinished &&
                          state.contactList.length <= 0) {
                        return _InfoText(
                          message: "You don't have any contacts...",
                        );
                      } else if (state is ContactListWatcherFinished &&
                          state.contactList.length > 0) {
                        final contactList = state.contactList;
                        return BlocBuilder<TransferFormCubit,
                            TransferFormState>(
                          builder: (context, state) => ListView.builder(
                            padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(16),
                            ),
                            itemCount: contactList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => context
                                    .read<TransferFormCubit>()
                                    .selectContact(index),
                                child: ContactListItem(
                                  contact: contactList[index],
                                  isSelected:
                                      state.indexContactListSelected.value ==
                                              index
                                          ? true
                                          : false,
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is ContactListWatcherLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ContactListWatcherError) {
                        return _InfoText(message: state.error.message);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText({
    @required this.message,
    Key key,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppTheme.defaultHorizontalPadding,
        child: Text(
          message,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            color: AppTheme.textColorDark,
            fontWeight: AppTheme.generalFontWeight,
          ),
        ),
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
      child: Expanded(
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
            Flexible(
              child: Text(
                "${contact.nickname}",
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: AppTheme.textColorDark,
                  fontWeight: isBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
