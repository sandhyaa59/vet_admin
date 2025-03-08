// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) =>
    json.encode(data.toJson());

class CategoryResponse {
  List<CategoryData>? data;
  int? totalPage;
  int? totalData;
  int? pageNumber;
  bool? hasNext;

  CategoryResponse({
    this.data,
    this.totalPage,
    this.totalData,
    this.pageNumber,
    this.hasNext,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        data: List<CategoryData>.from(
            json["data"].map((x) => CategoryData.fromJson(x))),
        totalPage: json["totalPage"],
        totalData: json["totalData"],
        pageNumber: json["pageNumber"],
        hasNext: json["hasNext"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalPage": totalPage,
        "totalData": totalData,
        "pageNumber": pageNumber,
        "hasNext": hasNext,
      };
}

class CategoryData {
  int? id;
  String? title;
  String? description;
  DateTime? addedTime;
  bool? isActive;
  int? parentCategoryId;
  String? parentCategoryName;
  dynamic categoryResponseList;

  CategoryData({
    this.id,
    this.title,
    this.description,
    this.addedTime,
    this.isActive,
    this.parentCategoryId,
    this.parentCategoryName,
    this.categoryResponseList,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        addedTime: DateTime.parse(json["addedTime"]),
        isActive: json["isActive"],
        parentCategoryId: json["parentCategoryId"],
        parentCategoryName: json["parentCategoryName"],
        categoryResponseList: json["categoryResponseList"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "addedTime": addedTime!.toIso8601String(),
        "isActive": isActive,
        "parentCategoryId": parentCategoryId,
        "parentCategoryName": parentCategoryName,
        "categoryResponseList": categoryResponseList,
      };
}
