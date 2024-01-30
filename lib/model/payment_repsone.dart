// To parse this JSON data, do
//
//     final paymentListResponse = paymentListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:vet_pharma/utils/helper.dart';

PaymentListResponse paymentListResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return PaymentListResponse.fromJson(jsonData);
}

String paymentListResponseToJson(PaymentListResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class PaymentListResponse {
    List<PaymentList>? data;
    int? totalPage;
    int? totalData;
    int? pageNumber;
    bool? hasNext;

    PaymentListResponse({
        this.data,
        this.totalPage,
        this.totalData,
        this.pageNumber,
        this.hasNext,
    });

    factory PaymentListResponse.fromJson(Map<String, dynamic> json) =>  PaymentListResponse(
        data:  List<PaymentList>.from(json["data"].map((x) => PaymentList.fromJson(x))),
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

class PaymentList {
    int? id;
    int? billId;
    String? paymentMode;
    String? paymentNumber;
    String? bankName;
    int? amount;
    dynamic mobileNumber;
    String? addedBy;
    String? addedAt;

    PaymentList({
        this.id,
        this.billId,
        this.paymentMode,
        this.paymentNumber,
        this.bankName,
        this.amount,
        this.mobileNumber,
        this.addedBy,
        this.addedAt,
    });

    factory PaymentList.fromJson(Map<String, dynamic> json) =>  PaymentList(
        id: json["id"],
        billId: json["billId"],
        paymentMode: json["paymentMode"],
        paymentNumber: json["paymentNumber"],
        bankName: json["bankName"],
        amount: json["amount"],
        mobileNumber: json["mobileNumber"],
        addedBy: json["addedBy"],
        addedAt:convertTimeStamp( json["addedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "paymentMode": paymentMode,
        "paymentNumber": paymentNumber,
        "bankName": bankName,
        "amount": amount,
        "mobileNumber": mobileNumber,
        "addedBy": addedBy,
        "addedAt": addedAt,
    };
}
