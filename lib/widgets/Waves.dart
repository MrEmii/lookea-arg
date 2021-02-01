import 'package:flutter/material.dart';

import 'LColors.dart';

class WaveNormal extends CustomPainter {

  @override
    void paint(Canvas canvas, Size size) {
      Paint paint = Paint()
      ..color = LColors.black9;
      Path path = Path();
      path.lineTo(size.width * 0.43, size.height * 0.89);
      path.cubicTo(size.width * 0.52, size.height * 0.96, size.width * 0.76, size.height * 1.13, size.width, size.height * 0.82);
      path.cubicTo(size.width, size.height * 0.82, size.width, 0, size.width, 0);
      path.cubicTo(size.width, 0, 0, 0, 0, 0);
      path.cubicTo(0, 0, 0, size.height * 0.74, 0, size.height * 0.74);
      path.cubicTo(size.width * 0.15, size.height * 0.59, size.width * 0.39, size.height * 0.85, size.width * 0.43, size.height * 0.89);
      path.cubicTo(size.width * 0.43, size.height * 0.89, size.width * 0.43, size.height * 0.89, size.width * 0.43, size.height * 0.89);
      canvas.drawPath(path, paint);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
    }
}

  class WaveLarge extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
      Paint paint = Paint();
      Path path = Path();
      paint.color = LColors.black9;

      path.lineTo(size.width / 2, size.height * 0.87);
      path.cubicTo(size.width * 0.75, size.height * 1.11, size.width, size.height * 0.84, size.width, size.height * 0.84);
      path.cubicTo(size.width, size.height * 0.45, size.width, 0, size.width, 0);
      path.cubicTo(size.width, 0, 0, 0, 0, 0);
      path.cubicTo(0, 0, 0, size.height * 0.71, 0, size.height * 1);
      path.cubicTo(size.width * 0.10, size.height * 0.78, size.width * 0.15, size.height * 0.64, size.width / 2, size.height * 0.87);
      path.cubicTo(size.width / 2, size.height * 0.87, size.width / 2, size.height * 0.87, size.width / 2, size.height * 0.87);
      canvas.drawPath(path, paint);
    }
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
    }
  }

 class CirclePainter extends CustomPainter {

   int heightfixed = 0;

   CirclePainter(this.heightfixed);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint..shader = new LinearGradient(colors: [Colors.yellow[700], Colors.redAccent],
      begin: Alignment.centerRight, end: Alignment.centerLeft).createShader(new Offset(0.0, 0.0)&size);
    canvas.drawRect(new Offset(0.0, 0.0)&size, paint);
    var path = new Path();
    path.moveTo(0.0, size.height);
    path.lineTo(1*size.width/4, 0*size.height/4);
    path.lineTo(2*size.width/4, 2*size.height/4);
    path.lineTo(3*size.width/4, 0*size.height/4);
    path.lineTo(4*size.width/4, 4*size.height/4);
    canvas.drawPath(path, new Paint()..color = Colors.yellow ..strokeWidth = 4.0 .. style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
