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
    String? customerEmail;
    String? customerMobileNo;
    String?createdAt;
    int? grandTotal;
    int? subTotal;
    int? discounts;
    int? tax;
    int? orderId;
    String? billNo;
    
    double? received;
    double? due;

    Bill({
        this.id,
        this.createdAt,
        this.customerName,
        this.customerEmail,
        this.customerMobileNo,
        this.grandTotal,
        this.subTotal,
        this.discounts,
        this.tax,
        this.orderId,
        this.billNo,
        this.due,
        this.received
    });

    factory Bill.fromJson(Map<String, dynamic> json) =>  Bill(
        id: json["id"],
        customerName: json["customerName"],
        createdAt: convertTimeStamp(json["createdAt"]),
        customerEmail: json["customerEmail"],
        customerMobileNo: json["customerMobileNo"],
        grandTotal: json["grandTotal"],
        subTotal: json["subTotal"],
        discounts: json["discounts"],
        tax: json["tax"],
        orderId: json["orderId"],
        billNo: json["billNo"],
        due: json["dueAmount"],
        received: json["receivedAmount"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customerName": customerName,
        "customerEmail": customerEmail,
        "customerMobileNo": customerMobileNo,
        "grandTotal": grandTotal,
        "subTotal": subTotal,
        "discounts": discounts,
        "tax": tax,
        "orderId": orderId,
        "billNo": billNo,
    };

  contains(String lowerCase) {}
}
