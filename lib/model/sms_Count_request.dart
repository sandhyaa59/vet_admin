// To parse this JSON data, do
//
//     final smsCountRequest = smsCountRequestFromJson(jsonString);

import 'dart:convert';

SmsCountRequest smsCountRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return SmsCountRequest.fromJson(jsonData);
}

String smsCountRequestToJson(SmsCountRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class SmsCountRequest {
    String? message;
    List<String>? mobileNumber;

    SmsCountRequest({
        this.message,
        this.mobileNumber,
    });

    factory SmsCountRequest.fromJson(Map<String, dynamic> json) =>  SmsCountRequest(
        message: json["message"],
        mobileNumber:  List<String>.from(json["mobileNumber"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "mobileNumber":  List<dynamic>.from(mobileNumber!.map((x) => x)),
    };
}
