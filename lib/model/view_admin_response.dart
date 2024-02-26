// To parse this JSON data, do
//
//     final viewAdminResponse = viewAdminResponseFromJson(jsonString);

import 'dart:convert';

ViewAdminResponse viewAdminResponseFromJson(String str) => ViewAdminResponse.fromJson(json.decode(str));

String viewAdminResponseToJson(ViewAdminResponse data) => json.encode(data.toJson());

class ViewAdminResponse {
    int? id;
    String? fullName;
    String ?emailId;
    String ?mobileNumber;
    bool ?isActive;
    dynamic maker;
    dynamic checker;
    dynamic deletedBy;
    DateTime? createdOn;
    dynamic modifiedOn;

    ViewAdminResponse({
         this.id,
         this.fullName,
         this.emailId,
         this.mobileNumber,
         this.isActive,
         this.maker,
         this.checker,
         this.deletedBy,
         this.createdOn,
         this.modifiedOn,
    });

    factory ViewAdminResponse.fromJson(Map<String, dynamic> json) => ViewAdminResponse(
        id: json["id"],
        fullName: json["fullName"],
        emailId: json["emailId"],
        mobileNumber: json["mobileNumber"],
        isActive: json["isActive"],
        maker: json["maker"],
        checker: json["checker"],
        deletedBy: json["deletedBy"],
        createdOn: DateTime.parse(json["createdOn"]),
        modifiedOn: json["modifiedOn"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "emailId": emailId,
        "mobileNumber": mobileNumber,
        "isActive": isActive,
        "maker": maker,
        "checker": checker,
        "deletedBy": deletedBy,
        "createdOn": createdOn!.toIso8601String(),
        "modifiedOn": modifiedOn,
    };
}
