import 'package:flutter/material.dart';

class GradientComponent extends StatelessWidget {

  final Widget child;
  final Gradient gradient;

  GradientComponent({this.child, @required this.gradient});

  @override
  Widget build(BuildContext context) {
   return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: this.child
    );
  }
}