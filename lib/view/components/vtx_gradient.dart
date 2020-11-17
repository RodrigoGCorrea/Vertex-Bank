import 'package:flutter/material.dart';

class VtxGradient extends StatelessWidget {
  final Widget child;
  final Color color;
  final Alignment begin;
  final Alignment end;

  const VtxGradient(
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
