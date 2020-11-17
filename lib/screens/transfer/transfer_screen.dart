import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:vertexbank/api/transfer.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/components/button.dart';
import 'package:vertexbank/components/transferscreen/contactlist.dart';
import 'package:vertexbank/components/transferscreen/transfer_screen_appbar.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';
import 'package:vertexbank/cubit/money/money_watcher_cubit.dart';
import 'package:vertexbank/cubit/transfer/form/transfer_form_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/screens/transfer/add_contact.dart';
import 'package:vertexbank/screens/transfer/confirm_transfer.dart';

class TransferScreen extends StatefulWidget {
  TransferScreen({Key key}) : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final transferFormCubit =
      TransferFormCubit(transferApi: getIt<TransferApi>());

  final MoneyMaskedTextController _moneyController =
      MoneyMaskedTextController(precision: 2);

  @override
  void dispose() {
    transferFormCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: transferFormCubit
        ..setUserInfo(context.watch<AuthCubit>().getSignedInUserWithoutEmit())
        ..setContactList(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Scaffold(
          body: _Background(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
                  BlocListener<MoneyWatcherCubit, MoneyWatcherState>(
                    listener: (context, state) {
                      context
                          .read<TransferFormCubit>()
                          .updateMoney(state.money);
                    },
                    child: BlocBuilder<TransferFormCubit, TransferFormState>(
                      buildWhen: (previous, current) =>
                          previous.amount != current.amount,
                      builder: (context, state) {
                        return TransferScreenAppBar(
                          moneyController: _moneyController,
                          functionChanged: (_) {
                            context
                                .read<TransferFormCubit>()
                                .amountChanged(_moneyController.numberValue);
                          },
                          errorText: !state.amount.isValid &&
                                  state.stage != TransferFormStage.initial
                              ? state.amount.errorText
                              : null,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  ContactList(),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  _NextButton(transferFormCubit: transferFormCubit),
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
                  NewContact(transferFormCubit: transferFormCubit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    Key key,
    @required this.transferFormCubit,
  }) : super(key: key);

  final TransferFormCubit transferFormCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferFormCubit, TransferFormState>(
      builder: (context, state) {
        final isFormValid =
            state.amount.isValid & state.indexContactListSelected.isValid;

        if (isFormValid) {
          return VtxButton(
            text: "Next",
            function: () {
              context.read<TransferFormCubit>().setTransferFormSelected();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: transferFormCubit,
                    child: TransferScreenConfirm(),
                  ),
                ),
              );
            },
          );
        } else {
          return VtxButton(
            text: "Next",
            function: () {
              context.read<TransferFormCubit>().setTransferFormSelectedError();
            },
          );
        }
      },
    );
  }
}

class NewContact extends StatelessWidget {
  final TransferFormCubit transferFormCubit;

  const NewContact({
    Key key,
    @required this.transferFormCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferFormCubit, TransferFormState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            //TODO(Geraldo): botar a tela de novo contato aqui!!
            //               Deixei essa função só pra lembrar como
            //               atualiza os contatos manualmente
            context.read<TransferFormCubit>().setContactList();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: transferFormCubit,
                  child: AddContact(),
                ),
              ),
            );
          },
          child: Text(
            "Add a new contact",
            style: TextStyle(
              color: AppTheme.textColor,
              fontSize: getProportionateScreenWidth(12),
              decoration: TextDecoration.underline,
            ),
          ),
        );
      },
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
