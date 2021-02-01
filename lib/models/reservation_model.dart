
class ReservationModel  {

  final String shopId;
  final double price;
  final String dateTime;
  final int methodPayment;

  ReservationModel(this.shopId, this.price, this.dateTime, this.methodPayment);



  factory ReservationModel.fromJson(Map<String, dynamic> model) => ReservationModel(
    model["id"],
    model["price"].toDouble(),
    model["date"],
    model["methodPayment"]
  );

  Map<String, dynamic> toJson() => {
    "id": this.shopId,
    "price": this.price,
    "date": this.dateTime,
    "methodPayment": this.methodPayment
  };
}