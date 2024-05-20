
class OrderDetail {
  final String? productId;
  final String? productName;
  final String? color;
  final String? size;
  final String? brandName;
  final int? quantity;
  final dynamic price;

  OrderDetail({
    this.productId,
    this.productName,
    this.color,
    this.size,
    this.brandName,
    this.quantity,
    this.price,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    productId: json["productId"],
    productName: json["productName"],
    color: json["color"],
    size: json["size"],
    brandName: json["brandName"],
    quantity: json["quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "color": color,
    "size": size,
    "brandName": brandName,
    "quantity": quantity,
    "price": price,
  };

  factory OrderDetail.fromMap(Map<String, dynamic> json) => OrderDetail(
    productId: json["productId"],
    productName: json["productName"],
    color: json["color"],
    size: json["size"],
    brandName: json["brandName"],
    quantity: json["quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toMap() => {
    "productId": productId,
    "productName": productName,
    "color": color,
    "size": size,
    "brandName": brandName,
    "quantity": quantity,
    "price": price,
  };
}