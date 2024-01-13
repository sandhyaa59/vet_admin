// To parse this JSON data, do
//
//     final organizationDetailResponse = organizationDetailResponseFromJson(jsonString);

import 'dart:convert';

OrganizationDetailResponse organizationDetailResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return OrganizationDetailResponse.fromJson(jsonData);
}

String organizationDetailResponseToJson(OrganizationDetailResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class OrganizationDetailResponse {
    int? id;
    String ?name;
    String ?email;
    String ?phoneNo;
    String ?panNo;
    dynamic logo;
    String ?address;

    OrganizationDetailResponse({
        this.id,
        this.name,
        this.email,
        this.phoneNo,
        this.panNo,
        this.logo,
        this.address,
    });

    factory OrganizationDetailResponse.fromJson(Map<String, dynamic> json) =>  OrganizationDetailResponse(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        panNo: json["panNo"],
        logo: json["logo"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "panNo": panNo,
        "logo": logo,
        "address": address,
    };
}
