// To parse this JSON data, do
//
//     final discountRequest = discountRequestFromJson(jsonString);

import 'dart:convert';

CategoryRequest categoryRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return CategoryRequest.fromJson(jsonData);
}

String categoryRequestToJson(CategoryRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class CategoryRequest {
  int?id;
    String? title;
    String? description;
    

    CategoryRequest({
      this.id,
        this.title,
        this.description,
    });

    factory CategoryRequest.fromJson(Map<String, dynamic> json) =>  CategoryRequest(
      id: json['id'],
        title: json["title"],
        description: json["description"],
     
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
       
    };
}
