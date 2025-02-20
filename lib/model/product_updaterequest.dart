// To parse this JSON data, do
//
//     final productUpdateRequest = productUpdateRequestFromJson(jsonString);

import 'dart:convert';

ProductUpdateRequest productUpdateRequestFromJson(String str) => ProductUpdateRequest.fromJson(json.decode(str));

String productUpdateRequestToJson(ProductUpdateRequest data) => json.encode(data.toJson());

class ProductUpdateRequest {
    int? id;
    String? title;
    String? description;
    int? stock;
    double ?costPrice;
    int? price;
    bool? hasDiscount;
    int? discountPercentage;
    String? unit;
    String? brand;
    int? categoryId;
    bool? isTaxable;
    int? taxPercent;

    ProductUpdateRequest({
         this.id,
         this.title,
         this.description,
         this.stock,
         this.costPrice,
         this.price,
         this.hasDiscount,
         this.discountPercentage,
         this.unit,
         this.brand,
         this.categoryId,
         this.isTaxable,
         this.taxPercent,
    });

    factory ProductUpdateRequest.fromJson(Map<String, dynamic> json) => ProductUpdateRequest(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        stock: json["stock"],
        costPrice: json["costPrice"]?.toDouble(),
        price: json["price"],
        hasDiscount: json["hasDiscount"],
        discountPercentage: json["discountPercentage"],
        unit: json["unit"],
        brand: json["brand"],
        categoryId: json["categoryId"],
        isTaxable: json["isTaxable"],
        taxPercent: json["taxPercent"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "stock": stock,
        "costPrice": costPrice,
        "price": price,
        "hasDiscount": hasDiscount,
        "discountPercentage": discountPercentage,
        "unit": unit,
        "brand": brand,
        "categoryId": categoryId,
        "isTaxable": isTaxable,
        "taxPercent": taxPercent,
    };
}
