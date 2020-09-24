import 'package:flutter/material.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';
import 'package:vertexbank/components/mainScreen/MainScreenAppBar.dart';
import 'package:vertexbank/components/vtx_gradient.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appBackgroundColor,
      body: VtxGradient(
        color: AppTheme.generalColorGreen,
        begin: Alignment.topLeft,
        child: Stack(
          children: [
            Positioned(
              top: VtxSizeConfig.screenHeight * 0.09,
              width: VtxSizeConfig.screenWidth,
              child: MainScreenAppBar(),
            ),
          ],
        ),
      ),
    );
  }
}
