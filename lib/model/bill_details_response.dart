// To parse this JSON data, do
//
//     final billDetailsResponse = billDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:vet_pharma/utils/helper.dart';

BillDetailsResponse billDetailsResponseFromJson(String str) => BillDetailsResponse.fromJson(json.decode(str));

String billDetailsResponseToJson(BillDetailsResponse data) => json.encode(data.toJson());

class BillDetailsResponse {
    int? id;
    String? customerName;
    String? customerEmail;
    OrderResponse? orderResponse;
    String? customerMobileNo;
    int? grandTotal;
    int? subTotal;
    int? discounts;
    int? tax;
    int? orderId;
    String? billNo;
    dynamic employeeName;
    dynamic createdBy;
    dynamic createdAt;

    BillDetailsResponse({
         this.id,
         this.customerName,
         this.customerEmail,
         this.orderResponse,
         this.customerMobileNo,
         this.grandTotal,
         this.subTotal,
         this.discounts,
         this.tax,
         this.orderId,
         this.billNo,
         this.employeeName,
         this.createdBy,
         this.createdAt,
    });

    factory BillDetailsResponse.fromJson(Map<String, dynamic> json) => BillDetailsResponse(
        id: json["id"],
        customerName: json["customerName"],
        customerEmail: json["customerEmail"],
        orderResponse: OrderResponse.fromJson(json["orderResponse"]),
        customerMobileNo: json["customerMobileNo"],
        grandTotal: json["grandTotal"],
        subTotal: json["subTotal"],
        discounts: json["discounts"],
        tax: json["tax"],
        orderId: json["orderId"],
        billNo: json["billNo"],
        employeeName: json["employeeName"],
        createdBy: json["createdBy"],
        createdAt: json["createdAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customerName": customerName,
        "customerEmail": customerEmail,
        // "orderResponse": orderResponse.toJson(),
        "customerMobileNo": customerMobileNo,
        "grandTotal": grandTotal,
        "subTotal": subTotal,
        "discounts": discounts,
        "tax": tax,
        "orderId": orderId,
        "billNo": billNo,
        "employeeName": employeeName,
        "createdBy": createdBy,
        "createdAt": createdAt,
    };
}

class OrderResponse {
    int? id;
    List<BillOrderResponse> ?responses;
    String? customerName;
    String? placeOfVisit;
    String? description;
    String? addedDateTime;
    int? employeeId;
    String? employeeName;
    bool? isVoid;
    bool? isDeleted;
    String? status;

    OrderResponse({
         this.id,
         this.responses,
         this.customerName,
         this.placeOfVisit,
         this.description,
         this.addedDateTime,
         this.employeeId,
         this.employeeName,
         this.isVoid,
         this.isDeleted,
         this.status,
    });

    factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        id: json["id"],
        responses:json["responses"]!=null? List<BillOrderResponse>.from(json["responses"].map((x) => BillOrderResponse.fromJson(x))).toList():[],
        customerName: json["customerName"],
        placeOfVisit: json["placeOfVisit"],
        description: json["description"],
        addedDateTime: convertTimeStamp(json["addedDateTime"]),
        employeeId: json["employeeId"],
        employeeName: json["employeeName"],
        isVoid: json["isVoid"],
        isDeleted: json["isDeleted"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        // "responses": List<dynamic>.from(responses.map((x) => x.toJson())),
        "customerName": customerName,
        "placeOfVisit": placeOfVisit,
        "description": description,
        // "addedDateTime": addedDateTime.toIso8601String(),
        "employeeId": employeeId,
        "employeeName": employeeName,
        "isVoid": isVoid,
        "isDeleted": isDeleted,
        "status": status,
    };
}

class BillOrderResponse {
    String? title;
    double? quantity;
    double? price;

    BillOrderResponse({
        required this.title,
        required this.quantity,
        required this.price,
    });

    factory BillOrderResponse.fromJson(Map<String, dynamic> json) => BillOrderResponse(
        title: json["title"],
        quantity: json["quantity"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "quantity": quantity,
        "price": price,
    };
}
