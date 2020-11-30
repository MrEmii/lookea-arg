import 'package:flutter/material.dart';

class DualWidget extends StatelessWidget {

  final Widget left;
  final Widget right;

  DualWidget({this.left, this.right});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Padding(
            child: left,
            padding: EdgeInsets.only(right: 7.5))),

        Flexible(
          child: Padding(
            child: right,
            padding: EdgeInsets.only(left: 7.5))),
      ],
    );
  }
}