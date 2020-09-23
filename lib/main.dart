import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/screens/login.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme.appBackgroundColor,
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _firebaseInit = false;
  bool _firebaseError = false;

  void initFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
          _firebaseInit = true;
      });
    } catch(e) {
      setState(() {
          _firebaseError = true;
      });
    }
  }

  @override
  void initState() {
    initFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_firebaseError) {
      // NOTE(geraldo): create a screen for connection erro
      print("[VTX] Firebase error!!!");
    }

    if (!_firebaseInit) {
      // NOTE(geraldo): create a screen for loading
      print("[VTX] Loading...");
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            Vtx_SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Roboto',
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: LoginScreen(),
            );
          },
        );
      },
    );
  }
}
