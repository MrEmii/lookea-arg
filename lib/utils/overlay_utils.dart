import 'package:flutter/material.dart';

import '../widgets/LColors.dart';

class OverlayUtils{
  static void showLoading(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Container(
        width: 50,
        height: 50,
        child: Center(child: CircularProgressIndicator())
      )
    );
  }

  static Future showAlert(BuildContext context, {String description, bool dismissible = false}) async {
    return showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(color: LColors.black9),
        content: Container(
          child: Text(description)
        ),
      )
    );
  }
}