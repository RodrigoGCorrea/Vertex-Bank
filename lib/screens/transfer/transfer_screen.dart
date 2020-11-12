import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/transferscreen/contactlist.dart';
import 'package:vertexbank/components/transferscreen/transfer_screen_appbar.dart';
import 'package:vertexbank/components/vtx_gradient.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';
import 'package:vertexbank/cubit/transfer/transfer_cubit.dart';
import 'package:vertexbank/models/contact.dart';

class TransferScreen extends StatelessWidget {
  TransferScreen({Key key}) : super(key: key);

  final MoneyMaskedTextController _moneyController =
      MoneyMaskedTextController(precision: 2);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<TransferCubit>().cleanUpInitial();
        return Future.value(true);
      },
      child: Scaffold(
        body: _Background(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
                BlocBuilder<TransferCubit, TransferScreenState>(
                  buildWhen: (previous, current) =>
                      previous.amount != current.amount,
                  builder: (context, state) {
                    return TransferScreenAppBar(
                      moneyController: _moneyController,
                      functionChanged: (_) {
                        final user = context
                            .read<AuthCubit>()
                            .getSignedInUserWithoutEmit();
                        context.read<TransferCubit>().amountChanged(
                            _moneyController.numberValue, user.money);
                      },
                      errorText: !state.amount.isValid &&
                              state.stage != TransferScreenStage.initial
                          ? state.amount.errorText
                          : null,
                    );
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                ContactList(contactList: contactListSample),
                SizedBox(height: getProportionateScreenHeight(40)),
                BlocBuilder<TransferCubit, TransferScreenState>(
                  builder: (context, state) {
                    final isFormValid = state.amount.isValid &
                        state.indexContactListSelected.isValid;
                    if (isFormValid) {
                      return VtxButton(
                        text: "Next",
                        function: () {
                          final user = context
                              .read<AuthCubit>()
                              .getSignedInUserWithoutEmit();
                          context
                              .read<TransferCubit>()
                              .proceedTransfer(user.id, user.name);
                          Navigator.pushNamed(
                              context, '/transfer/confirmation');
                        },
                      );
                    } else {
                      return VtxButton(
                        text: "Next",
                        function: () {
                          final user = context
                              .read<AuthCubit>()
                              .getSignedInUserWithoutEmit();
                          context
                              .read<TransferCubit>()
                              .proceedTransfer(user.id, user.name);
                        },
                      );
                    }
                  },
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
                  //TODO(Geraldo): botar a tela de novo contato aqui!!
                  //               Deixei essa função só pra lembrar como
                  //               atualiza os contatos manualmente
                  function: () => context.read<TransferCubit>().setContactList(
                        context
                            .read<AuthCubit>()
                            .getSignedInUserWithoutEmit()
                            .id,
                      ),
                ),
              ],
            ),
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

class _Background extends StatelessWidget {
  final Widget child;

  const _Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: VtxSizeConfig.screenWidth,
      height: VtxSizeConfig.screenHeight,
      color: AppTheme.appBackgroundColor,
      child: child,
    );
  }
}

class _BackgroundOld extends StatelessWidget {
  final Widget child;

  const _BackgroundOld({
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
