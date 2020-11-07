import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';
import 'package:vertexbank/cubit/auth/auth_cubit.dart';

class MainScreenAppBar extends StatelessWidget {
  final BuildContext context;
  MainScreenAppBar({
    Key key,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.defaultHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back,",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: AppTheme.textColor,
              fontWeight: FontWeight.w100,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jorge Dorival",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(36),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              IconButton(
                onPressed: () => context.read<AuthCubit>().signOut(),
                icon: SvgPicture.asset(
                  "assets/icons/cog-solid.svg",
                  color: AppTheme.textColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
