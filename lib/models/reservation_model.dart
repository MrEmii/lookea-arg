class ReservationModel  {

  String shopId;
  double price;
  DateTime dateTime;
  int methodPayment;


  factory ReservationModel.fromJson(Map<String, dynamic> model) {}

  Map<String, dynamic> toJson() => {};

}