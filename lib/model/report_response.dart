// To parse this JSON data, do
//
//     final reportResponse = reportResponseFromJson(jsonString);

import 'dart:convert';

import 'package:vet_pharma/utils/helper.dart';

ReportResponse reportResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return ReportResponse.fromJson(jsonData);
}

String reportResponseToJson(ReportResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class ReportResponse {
    List<Report>? data;
    int? totalPage;
    int? totalData;
    int? pageNumber;
    bool? hasNext;

    ReportResponse({
        this.data,
        this.totalPage,
        this.totalData,
        this.pageNumber,
        this.hasNext,
    });

    factory ReportResponse.fromJson(Map<String, dynamic> json) =>  ReportResponse(
        data:json["data"]!=null?  List<Report>.from(json["data"].map((x) => Report.fromJson(x))).toList():[],
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

class Report {
    int? id;
    List<StockInHand>? responses;
    String? customerName;
     String? customerAddress;
     String?shopName;
     String?customerPan;
    String? address;
    String? placeOfVisit;
    String? description;
    double? longitude;
    double? latitude;
    String? addedDateTime;
    int? employeeId;
    String? employeeName;

    Report({
        this.id,
        this.responses,
        this.customerName,
        this.shopName,
        this.customerPan,
        this.customerAddress,
        this.address,
        this.placeOfVisit,
        this.description,
        this.longitude,
        this.latitude,
        this.addedDateTime,
        this.employeeId,
        this.employeeName,
    });

    factory Report.fromJson(Map<String, dynamic> json) =>  Report(
        id: json["id"],
        responses:json["responses"]!=null?  List<StockInHand>.from(json["responses"].map((x) => StockInHand.fromJson(x))).toList():[],
        customerName: json["customerName"],
        customerAddress:json["customerAddress"],
        customerPan:json["customerPan"],
        address: json["address"],
        shopName:json["shopName"],
        placeOfVisit: json["placeOfVisit"],
        description: json["description"],
        longitude: json["longitude"].toDouble(),
        latitude: json["latitude"].toDouble(),
        addedDateTime:convertTimeStamp(json["addedDateTime"]) ,
        employeeId: json["employeeId"],
        employeeName: json["employeeName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        // "responses": new List<dynamic>.from(responses.map((x) => x.toJson())),
        "customerName": customerName,
        "shopName":shopName,
        "customerPan":customerPan,
        "address": address,
        "placeOfVisit": placeOfVisit,
        "description": description,
        "longitude": longitude,
        "latitude": latitude,
        "addedDateTime": addedDateTime,
        "employeeId": employeeId,
        "employeeName": employeeName,
    };
}

class StockInHand {
    String? title;
    int? quantity;

    StockInHand({
        this.title,
        this.quantity,
    });

    factory StockInHand.fromJson(Map<String, dynamic> json) => new StockInHand(
        title: json["title"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "quantity": quantity,
    };
}
