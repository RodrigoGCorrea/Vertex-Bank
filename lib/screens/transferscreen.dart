import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/transferscreen/contactlist.dart';
import 'package:vertexbank/components/transferscreen/transferscreenappbar.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/cubit/cubit/contactlist_cubit.dart';
import 'package:vertexbank/models/Contact.dart';
import 'package:vertexbank/screens/confirmtransfer.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _moneyController = MoneyMaskedTextController();
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
            TransferScreenAppBar(controller: _moneyController),
            SizedBox(height: getProportionateScreenHeight(30)),
            BlocProvider(
              create: (context) => ContactlistCubit(),
              child: ContactList(contactList: contactListSample),
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
            VtxButton(
              text: "Next",
              function: () => changeScreen(context),
            ),
            SizedBox(
              height: getProportionateScreenHeight(13),
            ),
            Text(
              "or",
              style: TextStyle(color: AppTheme.textColor),
            ),
            SizedBox(
              height: getProportionateScreenHeight(25),
            ),
            NewContact(
              function: () => {},
            ),
          ],
        ),
      ),
    );
  }
}

class NewContact extends StatelessWidget {
  final Function function;

  const NewContact({
    Key key,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Text(
        "Add a new contact",
        style: TextStyle(
          color: AppTheme.textColor,
          fontSize: getProportionateScreenWidth(12),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

changeScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ConfirmTransferScreen(),
    ),
  );
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

List<ContactListItem> contactListSample = [
  ContactListItem(
    contact: Contact("FDP Corp."),
  ),
  ContactListItem(
    contact: Contact("Marcelin Marreta"),
  ),
  ContactListItem(
    contact: Contact("Jaqueline Lasquera"),
  ),
  ContactListItem(
    contact: Contact("Edivaldo Jr."),
  ),
  ContactListItem(
    contact: Contact("Marcelin Marreta"),
  ),
  ContactListItem(
    contact: Contact("FDP Corp."),
  ),
  ContactListItem(
    contact: Contact("Edivaldo Jr."),
  ),
];
