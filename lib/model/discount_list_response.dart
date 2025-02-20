// To parse this JSON data, do
//
//     final discountListResponse = discountListResponseFromJson(jsonString);

import 'dart:convert';

List<DiscountListResponse> discountListResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return  List<DiscountListResponse>.from(jsonData.map((x) => DiscountListResponse.fromJson(x)));
}

String discountListResponseToJson(List<DiscountListResponse> data) {
    final dyn =  List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class DiscountListResponse {
    int ?id;
    String? name;
    String ?type;
    int? amount;

    DiscountListResponse({
        this.id,
        this.name,
        this.type,
        this.amount,
    });

    factory DiscountListResponse.fromJson(Map<String, dynamic> json) =>  DiscountListResponse(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "amount": amount,
    };
}



