// To parse this JSON data, do
//
//     final organizationListRequest = organizationListRequestFromJson(jsonString);

import 'dart:convert';

OrganizationListRequest organizationListRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return OrganizationListRequest.fromJson(jsonData);
}

String organizationListRequestToJson(OrganizationListRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class OrganizationListRequest {
    String? name;
    String? email;
    String? phoneNumer;
    int? panNo;
    String? address;

    OrganizationListRequest({
        this.name,
        this.email,
        this.phoneNumer,
        this.panNo,
        this.address,
    });

    factory OrganizationListRequest.fromJson(Map<String, dynamic> json) =>  OrganizationListRequest(
        name: json["name"],
        email: json["email"],
        phoneNumer: json["phoneNumer"],
        panNo: json["panNo"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phoneNumer": phoneNumer,
        "panNo": panNo,
        "address": address,
    };
}
