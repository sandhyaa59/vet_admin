// To parse this JSON data, do
//
//     final adminListResponse = adminListResponseFromJson(jsonString);

import 'dart:convert';

AdminListResponse adminListResponseFromJson(String str) => AdminListResponse.fromJson(json.decode(str));

String adminListResponseToJson(AdminListResponse data) => json.encode(data.toJson());

class AdminListResponse {
    List<Datum>? data;
    int? totalPage;
    int? totalData;
    int? pageNumber;
    bool? hasNext;

    AdminListResponse({
         this.data,
         this.totalPage,
         this.totalData,
         this.pageNumber,
         this.hasNext,
    });

    factory AdminListResponse.fromJson(Map<String, dynamic> json) => AdminListResponse(
        data:json["data"]!=null? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))).toList():[],
        totalPage: json["totalPage"],
        totalData: json["totalData"],
        pageNumber: json["pageNumber"],
        hasNext: json["hasNext"],
    );

    Map<String, dynamic> toJson() => {
        // "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalPage": totalPage,
        "totalData": totalData,
        "pageNumber": pageNumber,
        "hasNext": hasNext,
    };
}

class Datum {
    int? id;
    String? fullName;
    String? email;
    String? mobileNumber;
    DateTime? createdAt;
    bool? isActive;

    Datum({
         this.id,
         this.fullName,
         this.email,
         this.mobileNumber,
         this.createdAt,
         this.isActive,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "mobileNumber": mobileNumber,
        // "createdAt": createdAt.toIso8601String(),
        "isActive": isActive,
    };
}
