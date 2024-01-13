// To parse this JSON data, do
//
//     final checkInOutResponse = checkInOutResponseFromJson(jsonString);

import 'dart:convert';

import 'package:vet_pharma/utils/helper.dart';

CheckInOutResponse checkInOutResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return CheckInOutResponse.fromJson(jsonData);
}

String checkInOutResponseToJson(CheckInOutResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class CheckInOutResponse {
    List<CheckInOut>? data;
    int? totalPage;
    int? totalData;
    int? pageNumber;
    bool? hasNext;

    CheckInOutResponse({
        this.data,
        this.totalPage,
        this.totalData,
        this.pageNumber,
        this.hasNext,
    });

    factory CheckInOutResponse.fromJson(Map<String, dynamic> json) =>  CheckInOutResponse(
        data:json["data"]!=null?  List<CheckInOut>.from(json["data"].map((x) => CheckInOut.fromJson(x))).toList():[],
        totalPage: json["totalPage"],
        totalData: json["totalData"],
        pageNumber: json["pageNumber"],
        hasNext: json["hasNext"],
    );

    Map<String, dynamic> toJson() => {
        // "data": new List<dynamic>.from(data.map((x) => x.toJson())),
        "totalPage": totalPage,
        "totalData": totalData,
        "pageNumber": pageNumber,
        "hasNext": hasNext,
    };
}

class CheckInOut {
    int? id;
    String? checkInDescription;
    String? checkInTime;
    String? checkoutDescription;
    String? checkoutTime;
    bool? isCompleted;
    bool? isCheckin;
    String? employeeName;

    CheckInOut({
        this.id,
        this.checkInDescription,
        this.checkInTime,
        this.checkoutDescription,
        this.checkoutTime,
        this.isCompleted,
        this.isCheckin,
        this.employeeName
    });

    factory CheckInOut.fromJson(Map<String, dynamic> json) =>  CheckInOut(
        id: json["id"],
        checkInDescription: json["checkInDescription"],
        checkInTime:convertTimeStamp( json["checkInTime"]),
        checkoutDescription: json["checkoutDescription"],
        checkoutTime:json["checkoutTime"]!=null? convertTimeStamp( json["checkoutTime"]):"",
        isCompleted: json["isCompleted"],
        isCheckin: json["isCheckin"],
        employeeName: json["employeeName"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "checkInDescription": checkInDescription,
        "checkInTime": checkInTime,
        "checkoutDescription": checkoutDescription,
        "checkoutTime": checkoutTime,
        "isCompleted": isCompleted,
        "isCheckin": isCheckin,
    };
}
