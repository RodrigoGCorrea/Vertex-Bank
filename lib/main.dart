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
    @required this.authApi,
  })  : assert(authApi != null),
        signupCubit = SignupCubit(authApi: authApi),
        super(key: key);

  final AuthApi authApi;
  final SignupCubit signupCubit;

  // NOTE(Geraldo): Removi os try do firebase. Talvez verificar se a conexão
  //                deu certo no main, ainda não sei.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authApi,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(authApi: authApi),
          ),
          BlocProvider(
            create: (context) => TransferScreenCubit(),
          )
        ],
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
          },
        ),
      ),
    );
  }
}
