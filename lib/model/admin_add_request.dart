// To parse this JSON data, do
//
//     final adminAddRequest = adminAddRequestFromJson(jsonString);

import 'dart:convert';

AdminAddRequest adminAddRequestFromJson(String str) => AdminAddRequest.fromJson(json.decode(str));

String adminAddRequestToJson(AdminAddRequest data) => json.encode(data.toJson());

class AdminAddRequest {
    String? email;
    String ?password;
    String ?mobileNumber;
    String ?fullName;

    AdminAddRequest({
         this.email,
         this.password,
         this.mobileNumber,
         this.fullName,
    });

    factory AdminAddRequest.fromJson(Map<String, dynamic> json) => AdminAddRequest(
        email: json["email"],
        password: json["password"],
        mobileNumber: json["mobileNumber"],
        fullName: json["fullName"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "mobileNumber": mobileNumber,
        "fullName": fullName,
    };
}
