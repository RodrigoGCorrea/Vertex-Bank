import 'package:flutter/material.dart';

class Vtx_Gradient extends StatelessWidget {
  final Widget child;
  final Color color;
  final Alignment begin;
  final Alignment end;

  const Vtx_Gradient(
      {Key key,
      this.child,
      this.color,
      this.begin,
      this.end = const Alignment(0.8, 0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [color, Colors.transparent],
          tileMode: TileMode.clamp,
        ),
      ),
      child: child,
    );
  }
}
