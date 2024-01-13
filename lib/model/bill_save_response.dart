// To parse this JSON data, do
//
//     final billAddRequest = billAddRequestFromJson(jsonString);

import 'dart:convert';

BillAddRequest billAddRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return BillAddRequest.fromJson(jsonData);
}

String billAddRequestToJson(BillAddRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class BillAddRequest {
    String? customer;
    String? grandTotal;
    String? subTotal;
    String? discounts;
    String? tax;
    int? orderId;
    String ?billNo;

    BillAddRequest({
        this.customer,
        this.grandTotal,
        this.subTotal,
        this.discounts,
        this.tax,
        this.orderId,
        this.billNo,
    });

    factory BillAddRequest.fromJson(Map<String, dynamic> json) => new BillAddRequest(
        customer: json["customer"],
        grandTotal: json["grandTotal"],
        subTotal: json["subTotal"],
        discounts: json["discounts"],
        tax: json["tax"],
        orderId: json["orderId"],
        billNo: json["billNo"],
    );

    Map<String, dynamic> toJson() => {
        "customer": customer,
        "grandTotal": grandTotal,
        "subTotal": subTotal,
        "discounts": discounts,
        "tax": tax,
        "orderId": orderId,
        "billNo": billNo,
    };
}
