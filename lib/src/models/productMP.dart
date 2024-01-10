import 'dart:convert';

ProductMP productFromJson(String str) => ProductMP.fromJson(json.decode(str));

String productToJson(ProductMP data) => json.encode(data.toJson());

class ProductMP {
  String? id;
  String? title;
  String? description;
  String? picture_url;
  String? category_id;
  int? quantity;
  double? unit_price;
  List<ProductMP> toList = [];

  ProductMP({
    this.id,
    this.title,
    this.description,
    this.picture_url,
    this.category_id,
    this.quantity,
    this.unit_price,
  });

  factory ProductMP.fromJson(Map<String, dynamic> json) => ProductMP(
        id: json["id"] == null
            ? 0
            : json["id"] is int
                ? json["id"].toString()
                : json['id'],
        title: json["title"],
        description: json["description"],
        picture_url: json["picture_url"],
        category_id: json["category_id"],
        quantity: json["quantity"] == null
            ? 0
            : json["quantity"] is int
                ? json["quantity"]
                : int.parse(json['quantity']),
        unit_price: json["unit_price"] == null
            ? 0
            : json['unit_price'] is String
                ? double.parse(json["unit_price"])
                : isInteger(json["unit_price"])
                    ? json["unit_price"].toDouble()
                    : json['unit_price'],
      );

  ProductMP.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    if (jsonList.isEmpty) return;
    for (var item in jsonList) {
      ProductMP product = ProductMP.fromJson(item);
      toList.add(product);
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "picture_url": picture_url,
        "category_id": category_id,
        "quantity": quantity,
        "unit_price": unit_price,
      };

  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();
}
