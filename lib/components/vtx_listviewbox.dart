import 'package:flutter/material.dart';
import 'package:vertexbank/config/apptheme.dart';
import 'package:vertexbank/config/size_config.dart';

class VtxListViewBox extends StatelessWidget {
  VtxListViewBox({
    Key key,
    @required this.width,
    @required this.height,
    @required this.listViewBuilder,
  }) : super(key: key);

  final double width;
  final double height;
  final Widget listViewBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VtxListViewBoxBackground(
            width: width,
            height: height,
          ),
          Positioned(
            width: width - getProportionateScreenWidth(74),
            height: height,
            child: listViewBuilder,
          ),
        ],
      ),
    );
  }
}

class VtxListViewBoxBackground extends StatelessWidget {
  const VtxListViewBoxBackground({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(width),
      height: getProportionateScreenHeight(height),
      decoration: AppTheme.vtxBuildBoxDecoration(),
      child: Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: getProportionateScreenWidth(31),
          ),
          VerticalDivider(
            color: AppTheme.textColor,
            thickness: 1.5,
          ),
          SizedBox(
            width: getProportionateScreenWidth(204),
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
