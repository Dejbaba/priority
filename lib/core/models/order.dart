
import 'package:priority_test/core/models/order_detail.dart';
import 'package:priority_test/core/models/payment_detail.dart';

class Order {
  final String? id;
  final String? paymentMethod;
  final String? location;
  final List<OrderDetail>? orderDetail;
  final PaymentDetail? paymentDetail;
  final DateTime? createdDate;

  Order({
    this.id,
    this.paymentMethod,
    this.location,
    this.orderDetail,
    this.paymentDetail,
    this.createdDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    paymentMethod: json["paymentMethod"],
    location: json["location"],
    orderDetail: json["orderDetail"] == null ? [] : List<OrderDetail>.from(json["orderDetail"]!.map((x) => OrderDetail.fromJson(x))),
    paymentDetail: json["paymentDetail"] == null ? null : PaymentDetail.fromJson(json["paymentDetail"]),
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paymentMethod": paymentMethod,
    "location": location,
    "orderDetail": orderDetail == null ? [] : List<dynamic>.from(orderDetail!.map((x) => x.toJson())),
    "paymentDetail": paymentDetail?.toJson(),
    "createdDate": createdDate?.toIso8601String(),
  };

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    id: json["id"],
    paymentMethod: json["paymentMethod"],
    location: json["location"],
    orderDetail: json["orderDetail"] == null ? [] : List<OrderDetail>.from(json["orderDetail"]!.map((x) => OrderDetail.fromMap(x))),
    paymentDetail: json["paymentDetail"] == null ? null : PaymentDetail.fromMap(json["paymentDetail"]),
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "paymentMethod": paymentMethod,
    "location": location,
    "orderDetail": orderDetail == null ? [] : List<dynamic>.from(orderDetail!.map((x) => x.toMap())),
    "paymentDetail": paymentDetail?.toMap(),
    "createdDate": createdDate?.toIso8601String(),
  };
}