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
import 'package:vertexbank/cubit/transfer/form/transfer_form_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/screens/transfer/confirm_transfer.dart';

class TransferScreen extends StatefulWidget {
  TransferScreen({Key key}) : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final transferCubit = TransferFormCubit(transferApi: getIt<TransferApi>());

  final MoneyMaskedTextController _moneyController =
      MoneyMaskedTextController(precision: 2);

  @override
  void dispose() {
    transferCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: transferCubit
        ..setUserInfo(context.watch<AuthCubit>().getSignedInUserWithoutEmit())
        ..setContactList(),
      child: Scaffold(
        body: _Background(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
                BlocBuilder<TransferFormCubit, TransferFormState>(
                  buildWhen: (previous, current) =>
                      previous.amount != current.amount,
                  builder: (context, state) {
                    return TransferScreenAppBar(
                      moneyController: _moneyController,
                      functionChanged: (_) {
                        final user = context
                            .read<AuthCubit>()
                            .getSignedInUserWithoutEmit();
                        context.read<TransferFormCubit>().amountChanged(
                            _moneyController.numberValue, user.money);
                      },
                      errorText: !state.amount.isValid &&
                              state.stage != TransferFormStage.initial
                          ? state.amount.errorText
                          : null,
                    );
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                ContactList(),
                SizedBox(height: getProportionateScreenHeight(40)),
                _NextButton(transferCubit: transferCubit),
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
                  function: () =>
                      context.read<TransferFormCubit>().setContactList(),
                ),
              ],
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
    @required this.transferCubit,
  }) : super(key: key);

  final TransferFormCubit transferCubit;

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
                    value: transferCubit,
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
