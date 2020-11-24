import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/cubit/deposit/action/scanner/scanner_deposit_action_cubit.dart';
import 'package:vertexbank/getit.dart';
import 'package:vertexbank/view/screens/deposit/confirm_deposit.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
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
                  builder: (context) => ConfirmDeposit(),
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
                    borderColor: AppTheme.buttonColorGreen,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('This is the result of scan: $qrText'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(8),
                            child: RaisedButton(
                              onPressed: () {
                                if (controller != null) {
                                  controller.toggleFlash();
                                  if (_isFlashOn(flashState)) {
                                    setState(() {
                                      flashState = flashOff;
                                    });
                                  } else {
                                    setState(() {
                                      flashState = flashOn;
                                    });
                                  }
                                }
                              },
                              child: Text(flashState,
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            child: RaisedButton(
                              onPressed: () {
                                if (controller != null) {
                                  controller.flipCamera();
                                  if (_isBackCamera(cameraState)) {
                                    setState(() {
                                      cameraState = frontCamera;
                                    });
                                  } else {
                                    setState(() {
                                      cameraState = backCamera;
                                    });
                                  }
                                }
                              },
                              child: Text(cameraState,
                                  style: TextStyle(fontSize: 20)),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(8),
                            child: RaisedButton(
                              onPressed: () {
                                controller?.pauseCamera();
                              },
                              child:
                                  Text('pause', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            child: RaisedButton(
                              onPressed: () {
                                controller?.resumeCamera();
                              },
                              child: Text('resume',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  bool _isBackCamera(String current) {
    return backCamera == current;
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

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: VtxSizeConfig.screenWidth,
      height: VtxSizeConfig.screenHeight,
      color: AppTheme.appBackgroundColor,
      child: child,
    );
  }
}
