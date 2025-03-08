// To parse this JSON data, do
//
//     final categoryListsCategoryLists = categoryListsCategoryListsFromJson(jsonString);

import 'dart:convert';

List<CategoryLists> categoryListsCategoryListsFromJson(String str) =>
    List<CategoryLists>.from(
        json.decode(str).map((x) => CategoryLists.fromJson(x)));

String categoryListsCategoryListsToJson(List<CategoryLists> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryLists {
  int? id;
  String? title;
  String? description;
  DateTime? addedTime;
  bool? isActive;
  int? parentCategoryId;
  String? parentCategoryName;
  dynamic categoryResponseList;

  CategoryLists({
    this.id,
    this.title,
    this.description,
    this.addedTime,
    this.isActive,
    this.parentCategoryId,
    this.parentCategoryName,
    this.categoryResponseList,
  });

  factory CategoryLists.fromJson(Map<String, dynamic> json) => CategoryLists(
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
