// To parse this JSON data, do
//
//     final organizationDetailResponse = organizationDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:vet_pharma/utils/helper.dart';

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
    String? name;
    String? email;
    String? phoneNo;
    String? panNo;
    dynamic logo;
    String? address;
    String? expiryDate;
    int? duration;
    int? employeeCount;
    int? smsCount;
    String? packageName;
    int? remainingSmsCount;

    OrganizationDetailResponse({
        this.id,
        this.name,
        this.email,
        this.phoneNo,
        this.panNo,
        this.logo,
        this.address,
        this.expiryDate,
        this.duration,
        this.employeeCount,
        this.smsCount,
        this.packageName,
        this.remainingSmsCount,
    });

    factory OrganizationDetailResponse.fromJson(Map<String, dynamic> json) =>  OrganizationDetailResponse(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        panNo: json["panNo"],
        
        logo: json["logo"],
        address: json["address"],
        expiryDate:json["expiryDate"]!=null? convertTimeStamp( json["expiryDate"]):"",
        duration: json["duration"],
        employeeCount: json["employeeCount"],
        smsCount: json["smsCount"],
        packageName: json["packageName"],
        remainingSmsCount: json["remainingSmsCount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "panNo": panNo,
        "logo": logo,
        "address": address,
        "expiryDate": expiryDate,
        "duration": duration,
        "employeeCount": employeeCount,
        "smsCount": smsCount,
        "packageName": packageName,
        "remainingSmsCount": remainingSmsCount,
    };
}
