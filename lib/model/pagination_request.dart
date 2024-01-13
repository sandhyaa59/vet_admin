// To parse this JSON data, do
//
//     final paginationRequest = paginationRequestFromJson(jsonString);

import 'dart:convert';

PaginationRequest paginationRequestFromJson(String str) => PaginationRequest.fromJson(json.decode(str));

String paginationRequestToJson(PaginationRequest data) => json.encode(data.toJson());

class PaginationRequest {
    int? page;
    int? pageSize;
    String? sort;
    String? sortParameter;

    PaginationRequest({
         this.page,
         this.pageSize,
         this.sort,
         this.sortParameter,
    });

    factory PaginationRequest.fromJson(Map<String, dynamic> json) => PaginationRequest(
        page: json["page"],
        pageSize: json["pageSize"],
        sort: json["sort"],
        sortParameter: json["sortParameter"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "sort": sort,
        "sortParameter": sortParameter,
    };
}
