// To parse this JSON data, do
//
//     final employeeManagementResponse = employeeManagementResponseFromJson(jsonString);

import 'dart:convert';

import 'package:vet_pharma/utils/helper.dart';

EmployeeManagementResponse employeeManagementResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return EmployeeManagementResponse.fromJson(jsonData);
}

String employeeManagementResponseToJson(EmployeeManagementResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class EmployeeManagementResponse {
    List<EmployeeDetails>? data;
    int? totalPage;
    int? totalData;
    int? pageNumber;
    bool? hasNext;

    EmployeeManagementResponse({
        this.data,
        this.totalPage,
        this.totalData,
        this.pageNumber,
        this.hasNext,
    });

    factory EmployeeManagementResponse.fromJson(Map<String, dynamic> json) =>  EmployeeManagementResponse(
        data: json["data"]!=null? List<EmployeeDetails>.from(json["data"].map((x) => EmployeeDetails.fromJson(x))).toList():[],
        totalPage: json["totalPage"],
        totalData: json["totalData"],
        pageNumber: json["pageNumber"],
        hasNext: json["hasNext"],
    );

    Map<String, dynamic> toJson() => {
        "data":  List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalPage": totalPage,
        "totalData": totalData,
        "pageNumber": pageNumber,
        "hasNext": hasNext,
    };
}

class EmployeeDetails {
    int? id;
    String? fullName;
    String? email;
    String? mobileNumber;
    String? createdAt;
    bool? isActive;

    EmployeeDetails({
        this.id,
        this.fullName,
        this.email,
        this.mobileNumber,
        this.createdAt,
        this.isActive,
    });

    factory EmployeeDetails.fromJson(Map<String, dynamic> json) =>  EmployeeDetails(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        createdAt:convertTimeStamp(json["createdAt"]) ,
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "mobileNumber": mobileNumber,
        "createdAt": createdAt,
        "isActive": isActive,
    };
}
