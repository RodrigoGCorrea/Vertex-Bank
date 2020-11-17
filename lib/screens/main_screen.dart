import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vertexbank/components/vtx_listviewbox.dart';

import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/components/mainScreen/main_screen_appbar.dart';
import 'package:vertexbank/components/mainScreen/balance_box.dart';
import 'package:vertexbank/components/mainScreen/transaction_list.dart';
import 'package:vertexbank/components/mainScreen/vtx_buttonbar.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';
import 'package:vertexbank/cubit/money/money_watcher_cubit.dart';
import 'package:vertexbank/cubit/transaction_list/transaction_list_watcher_cubit.dart';

class MainScreen extends StatelessWidget {
  MainScreen({
    Key key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    VtxSizeConfig().init(context);
    return Scaffold(
      body: _Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: VtxSizeConfig.screenHeight * 0.1),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is UnauthenticatedState)
                    Navigator.pushReplacementNamed(context, "/login");
                },
                buildWhen: (previous, current) => current is AuthenticatedState,
                builder: (context, state) {
                  if (state is AuthenticatedState)
                    return MainScreenAppBar(
                      userName: state.user.name,
                      configFunction: () => context.read<AuthCubit>().signOut(),
                    );
                  else
                    //This should never reach!!
                    return MainScreenAppBar(
                      userName: "",
                      configFunction: () => context.read<AuthCubit>().signOut(),
                    );
                },
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              BlocBuilder<MoneyWatcherCubit, MoneyWatcherState>(
                builder: (context, state) {
                  final money =
                      NumberFormat.currency(locale: 'pt_BR', symbol: "")
                          .format(state.money * 0.01);
                  return BalanceBox(money: money);
                },
              ),
              SizedBox(height: getProportionateScreenHeight(18)),
              BlocBuilder<TransactionListCubit, TransactionListState>(
                builder: (context, state) {
                  if (state.transactionList.length > 0) {
                    List<VtxTransactionItem> transactionListWidget = [];
                    state.transactionList.forEach((e) {
                      final money =
                          NumberFormat.currency(locale: 'pt_BR', symbol: "")
                              .format(e.amount * 0.01);
                      transactionListWidget.add(VtxTransactionItem(
                        userName: e.targetUser,
                        amount: money,
                        date: e.date,
                        received: e.received,
                      ));
                    });
                    return TransactionList(list: transactionListWidget);
                  } else {
                    return VtxListViewBox(
                        width: getProportionateScreenWidth(285),
                        height: getProportionateScreenHeight(187),
                        listViewBuilder: Center(
                          child: Padding(
                            padding: AppTheme.defaultHorizontalPadding,
                            child: Text(
                              "You didn't make any transactions...",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(14),
                                color: AppTheme.textColor,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ));
                  }
                },
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              VtxButtonBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

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
