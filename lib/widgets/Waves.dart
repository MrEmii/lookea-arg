import 'package:flutter/material.dart';

import 'LColors.dart';

class WaveTop extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = LColors.black9;

    var path = Path();

    path.moveTo(0,0);
    path.quadraticBezierTo(0,size.height*0.49,0,size.height*0.65);
    path.cubicTo(size.width*0.08,size.height*0.56,size.width*0.20,size.height*0.40,size.width*0.42,size.height*0.55);
    path.cubicTo(size.width*0.71,size.height*0.76,size.width*0.68,size.height*0.96,size.width,size.height*0.93);
    path.quadraticBezierTo(size.width*1.00,size.height*0.77,size.width,0);

    path.lineTo(0,0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}