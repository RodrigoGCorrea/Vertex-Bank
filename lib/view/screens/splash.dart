import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/cubit/auth/auth_action_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VtxSizeConfig().init(context);
    return BlocListener<AuthActionCubit, AuthActionState>(
      listenWhen: (previous, current) =>
          previous != current || previous == current,
      listener: (context, state) {
        EasyLoading.show(status: "Teste");
        if (state is AuthActionLoading) {
          EasyLoading.show();
        } else if (state is AuthActionUnauthenticated) {
          EasyLoading.dismiss();
          Navigator.pushReplacementNamed(context, "/login");
        } else if (state is AuthActionAuthenticated) {
          EasyLoading.dismiss();
          Navigator.pushReplacementNamed(context, "/main");
        } else if (state is AuthActionError) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error.message);
          Navigator.pushReplacementNamed(context, "/main");
        }
      },
      child: _Background(child: Center()),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

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
