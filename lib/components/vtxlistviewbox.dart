import 'package:flutter/material.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

class VtxListViewBox extends StatefulWidget {
  final double width;
  final double height;
  final Widget listViewBuilder;
  VtxListViewBox({
    Key key,
    @required this.width,
    @required this.height,
    @required this.listViewBuilder,
  }) : super(key: key);

  @override
  _VtxListViewBoxState createState() => _VtxListViewBoxState();
}

class _VtxListViewBoxState extends State<VtxListViewBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VtxListViewBoxBackground(),
          Positioned(
            width: widget.width - getProportionateScreenWidth(74),
            height: widget.height,
            child: widget.listViewBuilder,
          ),
        ],
      ),
    );
  }
}

class VtxListViewBoxBackground extends StatelessWidget {
  const VtxListViewBoxBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(285),
      height: getProportionateScreenHeight(187),
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
