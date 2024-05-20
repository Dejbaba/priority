
class PaymentDetail {
  final dynamic subTotal;
  final dynamic shipping;
  final dynamic total;

  PaymentDetail({
    this.subTotal,
    this.shipping,
    this.total,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
    subTotal: json["subTotal"],
    shipping: json["shipping"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "subTotal": subTotal,
    "shipping": shipping,
    "total": total,
  };

  factory PaymentDetail.fromMap(Map<String, dynamic> json) => PaymentDetail(
    subTotal: json["subTotal"],
    shipping: json["shipping"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "subTotal": subTotal,
    "shipping": shipping,
    "total": total,
  };
}