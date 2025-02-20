// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

import 'package:vet_pharma/utils/helper.dart';

OrderResponse orderResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return OrderResponse.fromJson(jsonData);
}

String orderResponseToJson(OrderResponse data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class OrderResponse {
  List<Order>? data;
  int? totalPage;
  int? totalData;
  int? pageNumber;
  bool? hasNext;

  OrderResponse({
    this.data,
    this.totalPage,
    this.totalData,
    this.pageNumber,
    this.hasNext,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        data: json["data"] != null
            ? List<Order>.from(json["data"].map((x) => Order.fromJson(x)))
                .toList()
            : [],
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

class Order {
  int? id;
  List<OrderedItem>? responses;
  String? customerName;
  String? placeOfVisit;
  String? customerAddress;
  String? shopName;
  String? customerPan;
  String? description;
  String? addedDateTime;
  int? employeeId;
  String? employeeName;
  bool? isVoid;
  bool? isDeleted;
  String? status;
  String? jobTitle;
  double? subTotal;
  double? taxableAmount;
  double? nonTaxableAmount;
  double? discountAmount;
  double? tax;
  double? grandTotal;

  Order({
    this.id,
    this.responses,
    this.customerName,
    this.placeOfVisit,
    this.customerAddress,
    this.description,
    this.addedDateTime,
    this.customerPan,
    this.shopName,
    this.employeeId,
    this.employeeName,
    this.isVoid,
    this.isDeleted,
    this.status,
    this.jobTitle,
    this.subTotal,
    this.taxableAmount,
    this.nonTaxableAmount,
    this.discountAmount,
    this.grandTotal,
    this.tax,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        responses: json["responses"] != null
            ? List<OrderedItem>.from(
                json["responses"].map((x) => OrderedItem.fromJson(x))).toList()
            : [],
        customerName: json["customerName"],
        customerAddress: json["customerAddress"],
        customerPan: json["customerPan"],
        placeOfVisit: json["placeOfVisit"],
        description: json["description"],
        addedDateTime: convertTimeStamp(json["addedDateTime"]),
        employeeId: json["employeeId"],
        employeeName: json["employeeName"],
        isVoid: json["isVoid"],
        isDeleted: json["isDeleted"],
        status: json["status"],
        shopName: json["shopName"],
        jobTitle: json["jobTitle"],
        subTotal: json['subTotal'],
        taxableAmount: json['taxableAmount'],
        nonTaxableAmount: json['nonTaxableAmount'],
        discountAmount: json['discountAmount'],
        tax: json['tax'],
        grandTotal: json['grandTotal']
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "responses":  List<dynamic>.from(responses.map((x) => x.toJson())),
        "customerName": customerName,
        "placeOfVisit": placeOfVisit,
        "description": description,
        "addedDateTime": addedDateTime,
        "employeeId": employeeId,
        "employeeName": employeeName,
        "isVoid": isVoid,
        "isDeleted": isDeleted,
        "status": status,
        "shopName": shopName,
        "subTotal":subTotal,
        "taxableAmount":taxableAmount,
        "nonTaxableAmount":nonTaxableAmount,
        "discountAmount":discountAmount,
        "tax":tax
      };
}

class OrderedItem {
  String? title;
  double? quantity;
  double? price;
  double? amount;
  String?unit;

  OrderedItem({
    this.title,
    this.quantity,
    this.price,
    this.amount,this.unit
  });

  factory OrderedItem.fromJson(Map<String, dynamic> json) => OrderedItem(
        title: json["title"],
        quantity: json["quantity"],
        price: json["price"],
        amount: json['amount'],
        unit: json["unit"]
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "quantity": quantity,
        "price": price,
        "amount":amount
      };
}
