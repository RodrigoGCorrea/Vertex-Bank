import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/cubit/deposit/action/scanner/scanner_deposit_action_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/view/screens/deposit/confirm_deposit.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<ScanScreen> {
  var qrText = '';

  var flashState = flashOn;

  var cameraState = frontCamera;

  QRViewController controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ScannerDepositActionCubit>(),
      child: Scaffold(
        body:
            BlocListener<ScannerDepositActionCubit, ScannerDepositActionState>(
          listener: (context, state) {
            if (state is ScannerDepositActionLoading) {
              EasyLoading.show(status: "Getting E-Check...");
            } else if (state is ScannerDepositActionError) {
              EasyLoading.dismiss();
              EasyLoading.showError(state.error.message);
            } else if (state is ScannerDepositActionFinished) {
              EasyLoading.dismiss();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmDepositScreen(),
                ),
              );
            }
          },
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: AppTheme.buttonColorBlue,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.distinct().listen((scanData) {
      getIt<ScannerDepositActionCubit>().parseECheckFromJson(scanData);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
