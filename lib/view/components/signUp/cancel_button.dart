import 'package:flutter/material.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/cubit/signup/signup_form_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SignUpFormCubit>().cleanUp();
        Navigator.popUntil(context, ModalRoute.withName("/login"));
      },
      child: Text(
        "Cancel",
        style: TextStyle(
          color: AppTheme.textColor,
          fontSize: getProportionateScreenWidth(12),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
