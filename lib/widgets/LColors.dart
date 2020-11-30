import 'package:flutter/material.dart';

class LColors {

  static const Color black9 = Color(0xff181818);
  static const Color white19 = Color(0xffCDCDCD);
  static const Color white26 = Color(0xffBBBBBB);
  static const Color gray50 = Color(0xff7D7D7D);
  static const Color red61 = Color(0xffB06262);
  static const Color red37 = Color(0xffB06262);
  static const Color gray3 = Color(0xff828282);
  static const Color gray6 = Color(0xfff2f2f2);
  static const Color gray1 = Color(0xff333333);
  static const Color gray4 = Color(0xffBDBDBD);
  static const Color green3 = Color(0xff6FCF97);
  static const Color gray2 = Color(0xff4F4F4F);

  static LinearGradient titleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end:   Alignment.bottomRight,
    colors: [
      Colors.transparent,
      Colors.black.withOpacity(50),
    ]
  );

  static LinearGradient translucentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end:   Alignment.bottomRight,
    colors: [
      Color(0xffC9D6FF),
      Color(0xffE2E2E2),
    ]
  );

  static LinearGradient blackGradient = LinearGradient(
    begin: Alignment.topLeft,
    end:   Alignment.bottomRight,
    colors: [
      Color(0xffECE9E6),
      Colors.white
    ]
  );

  static LinearGradient burningOrange = LinearGradient(
    begin: Alignment.topLeft,
    end:   Alignment.bottomRight,
    colors: [
      Color(0xFFFF416C),
      Color(0xFFFF4B2B),
    ]
  );

  static LinearGradient citrusPeel = LinearGradient(
    begin: Alignment.topLeft,
    end:   Alignment.bottomRight,
    colors: [
      Color(0xFFFDC830),
      Color(0xFFF37335),
    ]
  );

  static LinearGradient azurLane = LinearGradient(
    begin: Alignment.topLeft,
    end:   Alignment.bottomRight,
    colors: [
      Color(0xFF7F7FD5),
      Color(0xFF86A8E7),
      Color(0xFF91EAE4),
    ]
  );

  static LinearGradient gradientLove = LinearGradient(
    begin: Alignment.topLeft,
    end:   Alignment.bottomRight,
    colors: [
      Color(0xffFF9D9D),
      Color(0xFFBD569D),
    ]
  );

}