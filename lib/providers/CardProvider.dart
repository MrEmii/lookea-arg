import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier{

  TextEditingController cardController = TextEditingController();
  TextEditingController namedCardController = TextEditingController();
  TextEditingController ccvController = TextEditingController();
  TextEditingController expireController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController streetNumberController = TextEditingController();
  TextEditingController countyController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();


  notify() => this.notifyListeners();
}