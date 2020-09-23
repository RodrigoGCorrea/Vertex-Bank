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

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInit,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // NOTE(geraldo): create a screen for connection erro
          print("[VTX] Firebase error!!!");
        }

        if (snapshot.connectionState == ConnectionState.done) {
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

        // NOTE(geraldo): create a screen for loading
        print("[VTX] Loading...");

      },
    );
  }
}
