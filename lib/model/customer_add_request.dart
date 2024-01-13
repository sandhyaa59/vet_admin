// To parse this JSON data, do
//
//     final customerAddRequest = customerAddRequestFromJson(jsonString);

import 'dart:convert';

CustomerAddRequest customerAddRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return CustomerAddRequest.fromJson(jsonData);
}

String customerAddRequestToJson(CustomerAddRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class CustomerAddRequest {
    String? email;
    String? address;
    String? mobileNumber;
    String? name;

    CustomerAddRequest({
        this.email,
        this.address,
        this.mobileNumber,
        this.name,
    });

    factory CustomerAddRequest.fromJson(Map<String, dynamic> json) =>  CustomerAddRequest(
        email: json["email"],
        address: json["address"],
        mobileNumber: json["mobileNumber"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "address": address,
        "mobileNumber": mobileNumber,
        "name": name,
    };
}
