// To parse this JSON data, do
//
//     final updateAdminRequest = updateAdminRequestFromJson(jsonString);

import 'dart:convert';

UpdateAdminRequest updateAdminRequestFromJson(String str) => UpdateAdminRequest.fromJson(json.decode(str));

String updateAdminRequestToJson(UpdateAdminRequest data) => json.encode(data.toJson());

class UpdateAdminRequest {
    String? email;
    String? password;
    String ?mobileNumber;
    String ?fullName;
    String ?id;

    UpdateAdminRequest({
         this.email,
         this.password,
         this.mobileNumber,
         this.fullName,
         this.id,
    });

    factory UpdateAdminRequest.fromJson(Map<String, dynamic> json) => UpdateAdminRequest(
        email: json["email"],
        password: json["password"],
        mobileNumber: json["mobileNumber"],
        fullName: json["fullName"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "mobileNumber": mobileNumber,
        "fullName": fullName,
        "id": id,
    };
}
