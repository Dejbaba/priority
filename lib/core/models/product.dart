class Product {
  final String? id;
  String? wishlistId; ///used for wishlist implementation
  final String? productName;
  String? averageRating;
  int? totalReviews;
  final List<String>? colors;
  final List<String>? sizes;
  final int? quantity;
  final String? brandLogo;
  final String? brandName;
  final String? gender;
  final List<String>? productUrls;
  final double? price;
  final DateTime? createdDate;

  Product({
    this.id,
    this.wishlistId,
    this.productName,
    this.averageRating,
    this.totalReviews,
    this.colors,
    this.sizes,
    this.quantity,
    this.brandLogo,
    this.brandName,
    this.gender,
    this.productUrls,
    this.price,
    this.createdDate,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    wishlistId: json["wishlistId"],
    productName: json["productName"],
    gender: json["gender"],
    averageRating: json["averageRating"],
    totalReviews: json["totalReviews"],
    colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
    sizes: json["sizes"] == null ? [] : List<String>.from(json["sizes"]!.map((x) => x)),
    quantity: json["quantity"],
    brandLogo: json["brandLogo"],
    brandName: json["brandName"],
    productUrls: json["productUrls"] == null ? [] : List<String>.from(json["productUrls"]!.map((x) => x)),
    price: json["price"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "wishlistId": wishlistId,
    "productName": productName,
    "gender": gender,
    "averageRating": averageRating,
    "totalReviews": totalReviews,
    "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
    "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x)),
    "quantity": quantity,
    "brandLogo": brandLogo,
    "brandName": brandName,
    "productUrls": productUrls == null ? [] : List<dynamic>.from(productUrls!.map((x) => x)),
    "price": price,
    "createdDate": createdDate == null ? null : createdDate!.toIso8601String(),
  };

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    wishlistId: json["wishlistId"],
    gender: json["gender"],
    productName: json["productName"],
    averageRating: json["averageRating"],
    totalReviews: json["totalReviews"],
    colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
    sizes: json["sizes"] == null ? [] : List<String>.from(json["sizes"]!.map((x) => x)),
    quantity: json["quantity"],
    brandLogo: json["brandLogo"],
    brandName: json["brandName"],
    productUrls: json["productUrls"] == null ? [] : List<String>.from(json["productUrls"]!.map((x) => x)),
    price: json["price"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "wishlistId": wishlistId,
    "productName": productName,
    "gender": gender,
    "averageRating": averageRating,
    "totalReviews": totalReviews,
    "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
    "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x)),
    "quantity": quantity,
    "brandLogo": brandLogo,
    "brandName": brandName,
    "productUrls": productUrls == null ? [] : List<dynamic>.from(productUrls!.map((x) => x)),
    "price": price,
    "createdDate": createdDate == null ? null : createdDate?.toIso8601String(),
  };
}