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
  String?shopName;
  String?customerPan;
  String? description;
  String? addedDateTime;
  int? employeeId;
  String? employeeName;
  bool? isVoid;
  bool? isDeleted;
  String? status;

  Order({
    this.id,
    this.responses,
    this.customerName,
    this.customerAddress,
    this.customerPan,
    this.placeOfVisit,
    this.shopName,
    this.description,
    this.addedDateTime,
    this.employeeId,
    this.employeeName,
    this.isVoid,
    this.isDeleted,
    this.status,
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
        shopName: json["shopName"]
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
        "shopName":shopName
      };
}

class OrderedItem {
  String? title;
  double? quantity;
  double? price;

  OrderedItem({
    this.title,
    this.quantity,
    this.price,
  });

  factory OrderedItem.fromJson(Map<String, dynamic> json) => OrderedItem(
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
