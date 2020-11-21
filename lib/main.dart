import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:vertexbank/api/auth.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/cubit/auth/auth_action_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/view/screens/deposit/deposit_screen.dart';
import 'package:vertexbank/view/screens/login.dart';
import 'package:vertexbank/view/screens/main_screen.dart';
import 'package:vertexbank/view/screens/signup/signup.dart';
import 'package:vertexbank/view/screens/splash.dart';
import 'package:vertexbank/view/screens/transfer/transfer_screen.dart';
import 'package:vertexbank/view/screens/e_check/e_check_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthActionCubit>(
          create: (context) =>
              AuthActionCubit(authApi: getIt<AuthApi>())..getSignedInUser(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: (BuildContext context, Widget child) {
          return FlutterEasyLoading(child: child);
        },
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/main': (context) => MainScreen(),
          '/signup': (context) => SignUpScreen(),
          '/transfer': (context) => TransferScreen(),
          '/withdraw': (context) => ECheckScreen(),
          '/deposit': (context) => DepositScreen(),
        },
      ),
    );
  }
}
