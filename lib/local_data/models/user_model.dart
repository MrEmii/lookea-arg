import 'dart:convert';

import 'package:lookea/models/payment_model.dart';
import 'package:lookea/models/reservation_model.dart';

class UserModel {

  String id;
  String name;
  String lastname;
  String cellphone;
  String shopType;
  bool isClient;
  String photoUrl;
  List<PaymentModel> paymentsMethods;
  List<ReservationModel> reservations = [];

  UserModel({this.id, this.name, this.lastname, this.cellphone, this.shopType, this.isClient, this.photoUrl, this.paymentsMethods, this.reservations});

  factory UserModel.fromJson(Map<dynamic, dynamic> obj) => UserModel(
    id: obj["id"],
    name: obj["name"],
    lastname: obj["lastname"],
    cellphone: obj["cellphone"],
    shopType: obj["preference"],
    isClient: obj["isClient"],
    photoUrl: obj["photo"],
    paymentsMethods: obj["payments"].map<PaymentModel>((t) => PaymentModel.fromJson(t)).toList(),
    reservations: obj["reservations"].map<ReservationModel>((t) => ReservationModel.fromJson(t)).toList()
  );


  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "cellphone": cellphone,
    "preference": shopType,
    "client": isClient,
    "photo": photoUrl,
    "payments": paymentsMethods.map((e) => e.toJson()).toList(),
    "reservations": reservations.map((e) => e.toJson()).toList(),
  };

  UserModel copyWith({name, lastname, cellphone, city, county, shopType, street, streetNumber, isClient, photoUrl, paymentsMethods, reservations}) => UserModel(
    id: id,
    name: name??this.name,
    lastname: lastname??this.lastname,
    cellphone: cellphone??this.cellphone,
    shopType: shopType??this.shopType,
    isClient: isClient??this.isClient,
    paymentsMethods: paymentsMethods??this.paymentsMethods,
    photoUrl: photoUrl??this.photoUrl,
    reservations: reservations??this.reservations
  );

}