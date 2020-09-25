import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/screens/login.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/screens/main_screen.dart';

void main() {
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initilization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(home: Text("[VTX] Firebase error!!!"));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Roboto',
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: LoginScreen(),
            //home: LoginScreen(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(home: Text("[VTX] Loading..."));
      },
    );
  }
}
