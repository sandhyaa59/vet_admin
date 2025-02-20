// To parse this JSON data, do
//
//     final employeeUpdateRequest = employeeUpdateRequestFromJson(jsonString);

import 'dart:convert';

EmployeeUpdateRequest employeeUpdateRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return EmployeeUpdateRequest.fromJson(jsonData);
}

String employeeUpdateRequestToJson(EmployeeUpdateRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class EmployeeUpdateRequest {
    String? email;
    int? id;
    String? mobileNumber;
    String? fullName;
    String?jobTitle;

    EmployeeUpdateRequest({
        this.email,
        this.id,
        this.mobileNumber,
        this.fullName,
        this.jobTitle,
    });

    factory EmployeeUpdateRequest.fromJson(Map<String, dynamic> json) =>  EmployeeUpdateRequest(
        email: json["email"],
        id: json["id"],
        mobileNumber: json["mobileNumber"],
        fullName: json["fullName"],
        jobTitle: json["jobTitle"]
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "mobileNumber": mobileNumber,
        "fullName": fullName,
        "jobTitle":jobTitle
    };
}
