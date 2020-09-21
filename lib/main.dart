import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/screens/login.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppTheme.appBackgroundColor,
      statusBarColor: AppTheme.appBackgroundColor,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
