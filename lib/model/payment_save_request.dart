// To parse this JSON data, do
//
//     final paymentSaveRequest = paymentSaveRequestFromJson(jsonString);

import 'dart:convert';

PaymentSaveRequest paymentSaveRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return PaymentSaveRequest.fromJson(jsonData);
}

String paymentSaveRequestToJson(PaymentSaveRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class PaymentSaveRequest {
    String? amount;
    int? billId;
    int? employeeId;
    String? bankName;
    String? paymentMethod;
    String? paymentNumber;
    String? mobileNumber;

    PaymentSaveRequest({
        this.amount,
        this.billId,
        this.employeeId,
        this.bankName,
        this.paymentMethod,
        this.paymentNumber,
        this.mobileNumber,
    });

    factory PaymentSaveRequest.fromJson(Map<String, dynamic> json) =>  PaymentSaveRequest(
        amount: json["amount"],
        billId: json["billId"],
        employeeId: json["employeeId"],
        bankName: json["bankName"],
        paymentMethod: json["paymentMethod"],
        paymentNumber: json["paymentNumber"],
        mobileNumber: json["mobileNumber"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "billId": billId,
        "employeeId": employeeId,
        "bankName": bankName,
        "paymentMethod": paymentMethod,
        "paymentNumber": paymentNumber,
        "mobileNumber": mobileNumber,
    };
}
