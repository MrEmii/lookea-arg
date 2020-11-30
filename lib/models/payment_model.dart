enum PaymentType{
  CREDITO, DEBITO, EFECTIVO,
}
class PaymentModel{
  PaymentType paymentType;
  String numbers = "";
  int ccv = 0;
  String expire = "";

  PaymentModel(this.paymentType, this.numbers, this.ccv, this.expire);

  factory PaymentModel.fromJson(Map<String, dynamic> obj) => PaymentModel(
    PaymentType.values[obj["type"]],
    obj["numbers"] ?? "",
    obj["ccv"] ?? 0,
    obj["expire"] ?? ""
  );

  toJson() => <String, dynamic>{
    "type": paymentType.index,
    "numbers": numbers,
    "ccv": ccv,
    "expire": expire
  };

}