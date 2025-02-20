// To parse this JSON data, do
//
//     final discountRequest = discountRequestFromJson(jsonString);

import 'dart:convert';

DiscountRequest discountRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return DiscountRequest.fromJson(jsonData);
}

String discountRequestToJson(DiscountRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class DiscountRequest {
  int?id;
    String? name;
    String? discountType;
    int? amount;

    DiscountRequest({
      this.id,
        this.name,
        this.discountType,
        this.amount,
    });

    factory DiscountRequest.fromJson(Map<String, dynamic> json) =>  DiscountRequest(
      id: json['id'],
        name: json["name"],
        discountType: json["discountType"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "discountType": discountType,
        "amount": amount,
    };
}
