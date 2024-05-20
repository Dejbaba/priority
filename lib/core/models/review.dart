
class Review {
  final String? id;
  final double? rating;
  final String? productId;
  final String? reviewerName;
  final String? productName;
  final String? url;
  final String? description;
  final DateTime? createdDate;

  Review({
    this.id,
    this.rating,
    this.productId,
    this.reviewerName,
    this.productName,
    this.url,
    this.description,
    this.createdDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    rating: json["rating"],
    productId: json["productId"],
    reviewerName: json["reviewerName"],
    productName: json["productName"],
    url: json["url"],
    description: json["description"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "productId": productId,
    "reviewerName": reviewerName,
    "productName": productName,
    "url": url,
    "description": description,
    "createdDate": createdDate?.toIso8601String(),
  };

  factory Review.fromMap(Map<String, dynamic> json) => Review(
    id: json["id"],
    rating: json["rating"],
    productId: json["productId"],
    reviewerName: json["reviewerName"],
    productName: json["productName"],
    url: json["url"],
    description: json["description"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "rating": rating,
    "productId": productId,
    "reviewerName": reviewerName,
    "productName": productName,
    "url": url,
    "description": description,
    "createdDate": createdDate?.toIso8601String(),
  };
}