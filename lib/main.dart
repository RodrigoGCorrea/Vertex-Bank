import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:vertexbank/api/auth.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';
import 'package:vertexbank/cubit/transfer/transfer_cubit.dart';
import 'package:vertexbank/cubit/signup/signup_cubit.dart';
import 'package:vertexbank/screens/login.dart';
import 'package:vertexbank/screens/main_screen.dart';
import 'package:vertexbank/screens/signup/signup.dart';
import 'package:vertexbank/screens/signup/signup_finish.dart';
import 'package:vertexbank/screens/transfer/transfer_screen.dart';
import 'package:vertexbank/screens/transfer/confirm_transfer.dart';

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

  runApp(App(
    authApi: AuthApi(),
  ));
}

class App extends StatelessWidget {
  App({
    Key key,
    @required authApi,
  })  : assert(authApi != null),
        signupCubit = SignupCubit(authApi: authApi),
        authCubit = AuthCubit(authApi: authApi),
        transferCubit = TransferCubit(),
        super(key: key);

  final AuthCubit authCubit;
  final SignupCubit signupCubit;
  final TransferCubit transferCubit;

  // NOTE(Geraldo): Removi os try do firebase. Talvez verificar se a conexão
  //                deu certo no main, ainda não sei.
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/login',
        routes: {
          '/': (context) => MainScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => BlocProvider.value(
                value: signupCubit,
                child: SignUpScreen(),
              ),
          '/signup/finish': (context) => BlocProvider.value(
                value: signupCubit,
                child: SignUpFinishScreen(),
              ),
          '/transfer': (context) => BlocProvider.value(
                value: transferCubit,
                child: TransferScreen(),
              ),
          '/transfer/confirmation': (context) => BlocProvider.value(
                value: transferCubit,
                child: TransferScreenConfirm(),
              )
        },
      ),
    );
  }
}
