// To parse this JSON data, do
//
//     final reportStatResponse = reportStatResponseFromJson(jsonString);

import 'dart:convert';

ReportStatResponse reportStatResponseFromJson(String str) => ReportStatResponse.fromJson(json.decode(str));

class ReportStatResponse {
    int? totalOrders;
    double? totalRevenue;
    double? totalDiscount;
    double? totalTax;
    List<MostOrderedItem>? mostOrderedItems;

    ReportStatResponse({
        this.totalOrders,
        this.totalRevenue,
        this.totalDiscount,
        this.totalTax,
        this.mostOrderedItems,
    });

    factory ReportStatResponse.fromJson(Map<String, dynamic> json) => ReportStatResponse(
        totalOrders: json["totalOrders"],
        totalRevenue: json["totalRevenue"],
        totalDiscount: json["totalDiscount"],
        totalTax: json["totalTax"],
        mostOrderedItems: List<MostOrderedItem>.from(json["mostOrderedItems"].map((x) => MostOrderedItem.fromJson(x))),
    );
}

class MostOrderedItem {
    String? name;
    int? quantity;
    double? price;

    MostOrderedItem({
        this.name,
        this.quantity,
        this.price,
    });

    factory MostOrderedItem.fromJson(Map<String, dynamic> json) => MostOrderedItem(
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "price": price,
    };
}
