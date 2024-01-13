// To parse this JSON data, do
//
//     final customerListResponse = customerListResponseFromJson(jsonString);

import 'dart:convert';

CustomerListResponse customerListResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return CustomerListResponse.fromJson(jsonData);
}

String customerListResponseToJson(CustomerListResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class CustomerListResponse {
    List<CustomerList>? data;
    int? totalPage;
    int? totalData;
    int? pageNumber;
    bool? hasNext;

    CustomerListResponse({
        this.data,
        this.totalPage,
        this.totalData,
        this.pageNumber,
        this.hasNext,
    });

    factory CustomerListResponse.fromJson(Map<String, dynamic> json) =>  CustomerListResponse(
        data:  List<CustomerList>.from(json["data"].map((x) => CustomerList.fromJson(x))),
        totalPage: json["totalPage"],
        totalData: json["totalData"],
        pageNumber: json["pageNumber"],
        hasNext: json["hasNext"],
    );

    Map<String, dynamic> toJson() => {
        // "data":  List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalPage": totalPage,
        "totalData": totalData,
        "pageNumber": pageNumber,
        "hasNext": hasNext,
    };
}

class CustomerList {
    int? id;
    String? name;
    String? email;
    String? address;
    String? shopName;
    String? mobileNumber;
    bool ?isActive;
    bool? isDeleted;

    CustomerList({
        this.id,
        this.name,
        this.email,
        this.address,
        this.shopName,
        this.mobileNumber,
        this.isActive,
        this.isDeleted,
    });

    factory CustomerList.fromJson(Map<String, dynamic> json) =>  CustomerList(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        shopName: json["shopName"],
        mobileNumber: json["mobileNumber"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "shopName": shopName,
        "mobileNumber": mobileNumber,
        "isActive": isActive,
        "isDeleted": isDeleted,
    };
}
