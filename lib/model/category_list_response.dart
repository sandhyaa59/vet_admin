// To parse this JSON data, do
//
//     final categoryListResponse = categoryListResponseFromJson(jsonString);

import 'dart:convert';

List<CategoryListResponse> categoryListResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<CategoryListResponse>.from(jsonData.map((x) => CategoryListResponse.fromJson(x)));
}

String categoryListResponseToJson(List<CategoryListResponse> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class CategoryListResponse {
    int ?id;
    String? title;
    String? description;
    String? addedTime;
    bool? isActive;
    int? parentCategoryId;
    String? parentCategoryName;
    String? categoryResponseList;

    CategoryListResponse({
        this.id,
        this.title,
        this.description,
        this.addedTime,
        this.isActive,
        this.parentCategoryId,
        this.parentCategoryName,
        this.categoryResponseList,
    });

    factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>  CategoryListResponse(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        addedTime: json["addedTime"],
        isActive: json["isActive"],
        parentCategoryId: json["parentCategoryId"],
        parentCategoryName: json["parentCategoryName"],
        categoryResponseList: json["categoryResponseList"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "addedTime": addedTime,
        "isActive": isActive,
        "parentCategoryId": parentCategoryId,
        "parentCategoryName": parentCategoryName,
        "categoryResponseList": categoryResponseList,
    };
}
