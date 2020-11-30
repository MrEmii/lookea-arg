import 'dart:convert';

import 'package:lookea/models/payment_model.dart';

class UserModel {

  String id;
  String name;
  String lastname;
  String cellphone;
  String shopType;
  bool isClient;
  String photoUrl;
  List<PaymentModel> paymentsMethods;

  UserModel({this.id, this.name, this.lastname, this.cellphone, this.shopType, this.isClient, this.photoUrl, this.paymentsMethods});

  factory UserModel.fromJson(Map<String, dynamic> obj) => UserModel(
    id: obj["id"],
    name: obj["name"],
    lastname: obj["lastname"],
    cellphone: obj["cellphone"],
    shopType: obj["preference"],
    isClient: obj["isClient"] == 0,
    photoUrl: obj["photo"],
    paymentsMethods: (obj["payments"].runtimeType.toString() == "String" ? json.decode(obj["payments"]) : obj["payments"]).map<PaymentModel>((t) => PaymentModel.fromJson(t)).toList(),
  );


  Map<String, dynamic> toJson({toSQL = true}) => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "cellphone": cellphone,
    "preference": shopType,
    "client": isClient ? 0 : 1,
    "photo": photoUrl,
    "payments": toSQL ? json.encode(paymentsMethods.map((e) => e.toJson()).toList()) : paymentsMethods.map((e) => e.toJson()).toList()
  };

  UserModel copyWith({name, lastname, cellphone, city, county, shopType, street, streetNumber, isClient, photoUrl, paymentsMethods}) => UserModel(
    id: id,
    name: name??this.name,
    lastname: lastname??this.lastname,
    cellphone: cellphone??this.cellphone,
    shopType: shopType??this.shopType,
    isClient: isClient??this.isClient,
    paymentsMethods: paymentsMethods??this.paymentsMethods,
    photoUrl: photoUrl??this.photoUrl
  );

}