import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/transferscreen/contactlist.dart';
import 'package:vertexbank/components/transferscreen/transfer_screen_appbar.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/cubit/transfer/transfer_cubit.dart';
import 'package:vertexbank/models/contact.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
              TransferScreenAppBar(
                functionChanged: (amount) =>
                    context.read<TransferCubit>().amountChanged(amount),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              ContactList(contactList: contactListSample),
              SizedBox(height: getProportionateScreenHeight(40)),
              BlocListener<TransferCubit, TransferScreenState>(
                listener: (context, state) {
                  if (state is TransferScreenSelected) {
                    Navigator.of(context).pushNamed('/transfer/confirmation');
                  }
                },
                child: VtxButton(
                  text: "Next",
                  function: () =>
                      context.read<TransferCubit>().proceedTransfer(),
                ),
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

List<Contact> contactListSample = [
  Contact("FDP Corp."),
  Contact("Marcelin Marreta"),
  Contact("Jaqueline Lasquera"),
  Contact("Edivaldo Jr."),
  Contact("Marcelin Marreta"),
  Contact("FDP Corp."),
  Contact("Edivaldo Jr."),
];
