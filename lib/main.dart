import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:vertexbank/api/auth.dart';
import 'package:vertexbank/api/money.dart';
import 'package:vertexbank/api/transaction_list.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';
import 'package:vertexbank/cubit/money/money_watcher_cubit.dart';
import 'package:vertexbank/cubit/transaction_list/transaction_list_watcher_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/screens/login.dart';
import 'package:vertexbank/screens/main_screen.dart';
import 'package:vertexbank/screens/signup/signup.dart';
import 'package:vertexbank/screens/splash.dart';
import 'package:vertexbank/screens/transfer/transfer_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme.appBackgroundColor,
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
  getItSetup();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  // NOTE(Geraldo): Removi os try do firebase. Talvez verificar se a conexão
  //                deu certo no main, ainda não sei.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authApi: getIt<AuthApi>())..getSignedInUser(),
        ),
        BlocProvider<MoneyWatcherCubit>(
          create: (context) => MoneyWatcherCubit(moneyApi: getIt<MoneyApi>())
            ..setMoneyWatcher(
              context.read<AuthCubit>().getSignedInUserWithoutEmit().id,
            ),
        ),
        BlocProvider<TransactionListCubit>(
          create: (context) => TransactionListCubit(
              transactionListApi: getIt<TransactionListApi>())
            ..setTransactionListWatcher(
              context.read<AuthCubit>().getSignedInUserWithoutEmit().id,
            ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/main': (context) => MainScreen(),
          '/signup': (context) => SignUpScreen(),
          '/transfer': (context) => TransferScreen(),
        },
      ),
    );
  }
}
