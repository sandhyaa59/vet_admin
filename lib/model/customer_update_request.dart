// To parse this JSON data, do
//
//     final customerUpdateRequest = customerUpdateRequestFromJson(jsonString);

import 'dart:convert';

CustomerUpdateRequest customerUpdateRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return CustomerUpdateRequest.fromJson(jsonData);
}

String customerUpdateRequestToJson(CustomerUpdateRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class CustomerUpdateRequest {
    String? name;
    String? address;
    String? email;
    String? mobileNumber;
    int ?id;
    String? shopName;

    CustomerUpdateRequest({
        this.name,
        this.address,
        this.email,
        this.mobileNumber,
        this.id,
        this.shopName,
    });

    factory CustomerUpdateRequest.fromJson(Map<String, dynamic> json) =>  CustomerUpdateRequest(
        name: json["name"],
        address: json["address"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        id: json["id"],
        shopName: json["shopName"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "email": email,
        "mobileNumber": mobileNumber,
        "id": id,
        "shopName": shopName,
    };
}
