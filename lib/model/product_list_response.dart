// // To parse this JSON data, do
// //
// //     final productListResponse = productListResponseFromJson(jsonString);

// import 'dart:convert';

// ProductListResponse productListResponseFromJson(String str) {
//     final jsonData = json.decode(str);
//     return ProductListResponse.fromJson(jsonData);
// }

// String productListResponseToJson(ProductListResponse data) {
//     final dyn = data.toJson();
//     return json.encode(dyn);
// }

// class ProductListResponse {
//     List<Datum>? data;
//     int? totalPage;
//     int ?totalData;
//     int ?pageNumber;
//     bool? hasNext;

//     ProductListResponse({
//         this.data,
//         this.totalPage,
//         this.totalData,
//         this.pageNumber,
//         this.hasNext,
//     });

//     factory ProductListResponse.fromJson(Map<String, dynamic> json) =>  ProductListResponse(
//         data:  List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         totalPage: json["totalPage"],
//         totalData: json["totalData"],
//         pageNumber: json["pageNumber"],
//         hasNext: json["hasNext"],
//     );

//     Map<String, dynamic> toJson() => {
//         "data":  List<dynamic>.from(data!.map((x) => x.toJson())),
//         "totalPage": totalPage,
//         "totalData": totalData,
//         "pageNumber": pageNumber,
//         "hasNext": hasNext,
//     };
// }

// class Datum {
//     int? id;
//     int? categoryId;
//     String? categoryName;
//     String? title;
//     bool ?hasDiscount;
//     int? discountPercentage;
//     int? price;
//     dynamic unit;
//     String? brand;
//     dynamic slug;
//     dynamic imageUrl;

//     Datum({
//         this.id,
//         this.categoryId,
//         this.categoryName,
//         this.title,
//         this.hasDiscount,
//         this.discountPercentage,
//         this.price,
//         this.unit,
//         this.brand,
//         this.slug,
//         this.imageUrl,
//     });

//     factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
//         id: json["id"],
//         categoryId: json["categoryId"],
//         categoryName: json["categoryName"],
//         title: json["title"],
//         hasDiscount: json["hasDiscount"],
//         discountPercentage: json["discountPercentage"],
//         price: json["price"],
//         unit: json["unit"],
//         brand: json["brand"],
//         slug: json["slug"],
//         imageUrl: json["imageUrl"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "categoryId": categoryId,
//         "categoryName": categoryName,
//         "title": title,
//         "hasDiscount": hasDiscount,
//         "discountPercentage": discountPercentage,
//         "price": price,
//         "unit": unit,
//         "brand": brand,
//         "slug": slug,
//         "imageUrl": imageUrl,
//     };
// }





import 'dart:convert';

ProductListResponse productListResponseFromJson(String str) => ProductListResponse.fromJson(json.decode(str));

String productListResponseToJson(ProductListResponse data) => json.encode(data.toJson());

class ProductListResponse {
  List<Datum>? data;
  int? totalPage;
  int? totalData;
  int? pageNumber;
  bool? hasNext;

  ProductListResponse({
    this.data,
    this.totalPage,
    this.totalData,
    this.pageNumber,
    this.hasNext,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) => ProductListResponse(
        data: (json["data"] as List?)?.map((x) => Datum.fromJson(x)).toList() ?? [],
        totalPage: json["totalPage"] ?? 0,
        totalData: json["totalData"] ?? 0,
        pageNumber: json["pageNumber"] ?? 0,
        hasNext: json["hasNext"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "data": data?.map((x) => x.toJson()).toList() ?? [],
        "totalPage": totalPage ?? 0,
        "totalData": totalData ?? 0,
        "pageNumber": pageNumber ?? 0,
        "hasNext": hasNext ?? false,
      };
}

class Datum {
  int? id;
  int? categoryId;
  String? categoryName;
  String? title;
  String? description;
  bool? hasDiscount;
  double? discountPercentage;
  bool? hasTax;
  double? taxPercentage;
  double? price;
  double? costPrice;
  double? stock;
  DateTime? createdDateTime;
  dynamic updatedDateTime;
  bool? isActive;
  String? unit;
  String? brand;
  String? slug;

  Datum({
    this.id,
    this.categoryId,
    this.categoryName,
    this.title,
    this.description,
    this.hasDiscount,
    this.discountPercentage,
    this.hasTax,
    this.taxPercentage,
    this.price,
    this.costPrice,
    this.stock,
    this.createdDateTime,
    this.updatedDateTime,
    this.isActive,
    this.unit,
    this.brand,
    this.slug,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        categoryId: json["categoryId"] ?? 0,
        categoryName: json["categoryName"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        hasDiscount: json["hasDiscount"] ?? false,
        discountPercentage: json["discountPercentage"] ?? 0,
        hasTax: json["hasTax"] ?? false,
        taxPercentage: json["taxPercentage"] ?? 0,
        price: json["price"] ?? 0,
        costPrice: json["costPrice"] ?? 0,
        stock: json["stock"] ?? 0,
        createdDateTime: json["createdDateTime"] != null ? DateTime.tryParse(json["createdDateTime"]) : null,
        updatedDateTime: json["updatedDateTime"],
        isActive: json["isActive"] ?? false,
        unit: json["unit"] ?? "",
        brand: json["brand"] ?? "",
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "categoryId": categoryId ?? 0,
        "categoryName": categoryName ?? "",
        "title": title ?? "",
        "description": description ?? "",
        "hasDiscount": hasDiscount ?? false,
        "discountPercentage": discountPercentage ?? 0,
        "hasTax": hasTax ?? false,
        "taxPercentage": taxPercentage ?? 0,
        "price": price ?? 0,
        "costPrice": costPrice ?? 0,
        "stock": stock ?? 0,
        "createdDateTime": createdDateTime?.toIso8601String() ?? "",
        "updatedDateTime": updatedDateTime,
        "isActive": isActive ?? false,
        "unit": unit ?? "",
        "brand": brand ?? "",
        "slug": slug,
      };
}
