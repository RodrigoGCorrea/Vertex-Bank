import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:vertexbank/api/money.dart';
import 'package:vertexbank/api/transfer.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/view/components/background.dart';
import 'package:vertexbank/view/components/button.dart';
import 'package:vertexbank/view/components/transferscreen/contactlist.dart';
import 'package:vertexbank/view/components/transferscreen/transfer_screen_appbar.dart';
import 'package:vertexbank/cubit/auth/auth_action_cubit.dart';
import 'package:vertexbank/cubit/money/money_watcher_cubit.dart';
import 'package:vertexbank/cubit/transfer/form/transfer_form_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/view/screens/transfer/add_contact.dart';
import 'package:vertexbank/view/screens/transfer/confirm_transfer.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: transferFormCubit
            ..setUserInfo(
              context.watch<AuthActionCubit>().getSignedInUserWithoutEmit(),
            )
            ..setContactList(),
        ),
        BlocProvider<MoneyWatcherCubit>(
          create: (context) => MoneyWatcherCubit(moneyApi: getIt<MoneyApi>())
            ..setMoneyWatcher(
              context.read<AuthActionCubit>().getSignedInUserWithoutEmit().id,
            ),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Scaffold(
          body: Background(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
                  BlocListener<MoneyWatcherCubit, MoneyWatcherState>(
                    //Yeah... This is to force the listener to run when this screen is opened.
                    //If you, dear reader, know anything better let me know. Thanks.
                    listenWhen: (previous, current) =>
                        previous == current || previous != current,
                    listener: (context, state) {
                      context
                          .read<TransferFormCubit>()
                          .updateUserMoney(state.money);
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
                                .amountInputChanged(
                                    amountDouble: _moneyController.numberValue);
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
                    style: TextStyle(color: AppTheme.textColorLight),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: transferFormCubit,
                  child: AddContactScreen(),
                ),
              ),
            );
          },
          child: Text(
            "Add a new contact",
            style: TextStyle(
              color: AppTheme.textColorLight,
              fontSize: getProportionateScreenWidth(12),
              decoration: TextDecoration.underline,
            ),
          ),
        );
      },
    );
  }
}
