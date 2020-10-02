import 'package:flutter/material.dart';
import 'package:vertexbank/assets/apptheme.dart';
import 'package:vertexbank/assets/sizeconfig.dart';

class VtxListViewBox extends StatefulWidget {
  final List<Widget> list;
  VtxListViewBox({
    Key key,
    @required this.list,
  }) : super(key: key);

  @override
  _VtxListViewBoxState createState() => _VtxListViewBoxState();
}

class _VtxListViewBoxState extends State<VtxListViewBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(285),
      height: getProportionateScreenHeight(187),
      child: Stack(
        alignment: Alignment.center,
        children: [
          VtxListViewBoxBackground(),
          Positioned(
            width: getProportionateScreenWidth(211),
            height: getProportionateScreenHeight(187),
            child: ListView.builder(
              padding: EdgeInsets.only(top: getProportionateScreenHeight(16)),
              itemCount: widget.list.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.list[index];
              },
            ),
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
