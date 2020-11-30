import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lookea/widgets/LColors.dart';

Widget bottomBanner(){
  return ClipRRect(
    borderRadius: BorderRadius.circular(18),
    child: Container(
      color: Colors.white,
      child: Center(child: AdmobBanner(adUnitId: "ca-app-pub-3940256099942544/6300978111", adSize: AdmobBannerSize.FULL_BANNER)),
    ),
  );
}