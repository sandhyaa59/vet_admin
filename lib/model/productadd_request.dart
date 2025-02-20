import 'dart:convert';

ProductAddRequest productAddRequestFromJson(String str) {
  final jsonData = json.decode(str);
  return ProductAddRequest.fromJson(jsonData);
}

String productAddRequestToJson(ProductAddRequest data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class ProductAddRequest {
  String? title;
  double? price;
  double? costPrice;
  String? brand;
  String? description;
  int? categoryId;
  double? stock;
  String? unit;
int? id;
  bool? hasDiscount;
  double? discountPercentage;
  bool? hasTax;
  double? taxPercentage;

  ProductAddRequest({
    this.title,
    this.price,
    this.costPrice,
    this.brand,
    this.description,
    this.categoryId,
    this.stock,
    this.unit,
    this.id,

    this.hasDiscount,
    this.discountPercentage,
    this.hasTax,
    this.taxPercentage,
  });

  factory ProductAddRequest.fromJson(Map<String, dynamic> json) => ProductAddRequest(
        title: json["title"],
        price: json["price"],
        costPrice: json["costPrice"],
        brand: json["brand"],
        description: json["description"],
        categoryId: json["categoryId"],
        stock: json["stock"],
        unit: json["unit"],
      
        hasDiscount: json["hasDiscount"],
        discountPercentage: json["discountPercentage"],
        hasTax: json["hasTax"],
        taxPercentage: json["taxPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "costPrice": costPrice,
        "brand": brand,
        "description": description,
        "categoryId": categoryId,
        "stock": stock,
        "unit": unit,
       "id":id,
        "hasDiscount": hasDiscount,
        "discountPercentage": discountPercentage,
        "hasTax": hasTax,
        "taxPercentage": taxPercentage,
      };
}
