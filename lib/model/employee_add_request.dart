// To parse this JSON data, do
//
//     final employeeAddRequest = employeeAddRequestFromJson(jsonString);

import 'dart:convert';

EmployeeAddRequest employeeAddRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return EmployeeAddRequest.fromJson(jsonData);
}

String employeeAddRequestToJson(EmployeeAddRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class EmployeeAddRequest {
    String? email;
    String? password;
    String? mobileNumber;
    String? fullName;

    EmployeeAddRequest({
        this.email,
        this.password,
        this.mobileNumber,
        this.fullName,
    });

    factory EmployeeAddRequest.fromJson(Map<String, dynamic> json) => EmployeeAddRequest(
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
