import 'package:flutter/material.dart';
import 'package:lookea/models/payment_model.dart';

class ShopProvider extends ChangeNotifier{

  TextEditingController messageControler = TextEditingController(text: "");
  int hairdress;
  DateTime dateTime;
  PaymentModel payment;



  void notify(){
    this.notifyListeners();
  }


}