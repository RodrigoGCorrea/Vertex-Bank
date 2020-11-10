import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VtxSizeConfig().init(context);
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous != current || previous == current,
      listener: (context, state) {
        if (state is UnauthenticatedState) {
          Navigator.pushReplacementNamed(context, "/login");
        } else if (state is AuthenticatedState) {
          Navigator.pushReplacementNamed(context, "/main");
        } else if (state is ErrorState) {
          Navigator.pushReplacementNamed(context, "/main");
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.message),
            ),
          );
        }
      },
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
