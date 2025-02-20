// To parse this JSON data, do
//
//     final billResponse = billResponseFromJson(jsonString);

import 'dart:convert';


import 'package:vet_pharma/utils/helper.dart';

BillResponse billResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return BillResponse.fromJson(jsonData);
}

String billResponseToJson(BillResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class BillResponse {
    List<Bill> ?data;
    int? totalPage;
    int? totalData;
    int? pageNumber;
    bool? hasNext;

    BillResponse({
        this.data,
        this.totalPage,
        this.totalData,
        this.pageNumber,
        this.hasNext,
    });

    factory BillResponse.fromJson(Map<String, dynamic> json) =>  BillResponse(
        data: json["data"]!=null?  List<Bill>.from(json["data"].map((x) => Bill.fromJson(x))).toList():[],
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
class Bill {
  int? id;
  String? customerName;
  String? shopName;
  String? customerEmail;
  String? customerMobileNo;
  String? createdAt;
  double? grandTotal;
  double? subTotal;
  double? discounts;
  double? tax;
  int? orderId;
  String? billNo;
  double? received;
  double? due;

  Bill({
    this.id,
    this.createdAt,
    this.customerName,
    this.shopName,
    this.customerEmail,
    this.customerMobileNo,
    this.grandTotal,
    this.subTotal,
    this.discounts,
    this.tax,
    this.orderId,
    this.billNo,
    this.due,
    this.received,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"] ?? 0,
        customerName: json["customerName"] ?? "",
        shopName: json["shopName"] ?? "",
        createdAt: json["createdAt"] != null ? convertTimeStamp(json["createdAt"]) : "",
        customerEmail: json["customerEmail"] ?? "",
        customerMobileNo: json["customerMobileNo"] ?? "",
        grandTotal: json["grandTotal"] ?? 0,
        subTotal: json["subTotal"] ?? 0,
        discounts: json["discounts"] ?? 0,
        tax: json["tax"] ?? 0,
        orderId: json["orderId"] ?? 0,
        billNo: json["billNo"] ?? "",
        due: (json["dueAmount"] ?? 0).toDouble(),
        received: (json["receivedAmount"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "customerName": customerName ?? "",
        "shopName": shopName ?? "",
        "customerEmail": customerEmail ?? "",
        "customerMobileNo": customerMobileNo ?? "",
        "grandTotal": grandTotal ?? 0,
        "subTotal": subTotal ?? 0,
        "discounts": discounts ?? 0,
        "tax": tax ?? 0,
        "orderId": orderId ?? 0,
        "billNo": billNo ?? "",
        "dueAmount": due ?? 0.0,
        "receivedAmount": received ?? 0.0,
      };

  bool contains(String lowerCase) {
    return (customerName?.toLowerCase().contains(lowerCase) ?? false) ||
        (shopName?.toLowerCase().contains(lowerCase) ?? false) ||
        (customerEmail?.toLowerCase().contains(lowerCase) ?? false) ||
        (billNo?.toLowerCase().contains(lowerCase) ?? false);
  }
}
