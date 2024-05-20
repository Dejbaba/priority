
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  final String? id;
  final String? productName;
  final String? productId;
  final String? url;
  final String? size;
  final String? brandName;
  final String? color;
  int? quantity;
  final int? availableQuantity;
  final double? price;
  final DateTime? createdDate;
  final DateTime? updatedDate;

  CartProduct({
    this.id,
    this.productId,
    this.productName,
    this.url,
    this.size,
    this.brandName,
    this.color,
    this.quantity,
    this.availableQuantity,
    this.price,
    this.createdDate,
    this.updatedDate,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
    id: json["id"],
    productName: json["productName"],
    productId: json["productId"],
    url: json["url"],
    size: json["size"],
    color: json["color"],
    brandName: json["brandName"],
    quantity: json["quantity"],
    availableQuantity: json["availableQuantity"],
    price: json["price"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    updatedDate: json["updatedDate"] == null ? null : DateTime.parse(json["updatedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productName": productName,
    "productId": productId,
    "url": url,
    "size": size,
    "color": color,
    "brandName": brandName,
    "quantity": quantity,
    "availableQuantity": availableQuantity,
    "price": price,
    "createdDate": createdDate?.toIso8601String(),
    "updatedDate": updatedDate?.toIso8601String(),
  };

  factory CartProduct.fromMap(Map<String, dynamic> json) => CartProduct(
    id: json["id"],
    productName: json["productName"],
    productId: json["productId"],
    url: json["url"],
    size: json["size"],
    color: json["color"],
    brandName: json["brandName"],
    quantity: json["quantity"],
    availableQuantity: json["availableQuantity"],
    price: json["price"],
    // createdDate: json["createdDate"] == null ? null : DateTime.parse((json['createdDate'] as Timestamp).toDate().toString()),
    // updatedDate: json["updatedDate"] == null ? null : DateTime.parse((json['updatedDate'] as Timestamp).toDate().toString()),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "productName": productName,
    "productId": productId,
    "url": url,
    "color": color,
    "size": size,
    "brandName": brandName,
    "quantity": quantity,
    "availableQuantity": availableQuantity,
    "price": price,
    // "createdDate": createdDate?.toIso8601String(),
    // "updatedDate": updatedDate?.toIso8601String(),
  };
}