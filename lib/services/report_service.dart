import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/report_response.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class ReportService {
  static Future<dynamic> reportList(PaginationRequest request) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse("${EndPoints.REPORT_LIST}?page=${request.page}&pageSize=${request.pageSize}");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };

      var response = await http.get(uri, headers: headers);
      var res = handleResponse(response);
      ReportResponse reportResponse = reportResponseFromJson(res);

      return reportResponse;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> reportListByEmployee(int id) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse("${EndPoints.REPORT_EMPLOYEE}${id}");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.get(uri, headers: headers);
      var res = handleResponse(response);
      ReportResponse reportResponse = reportResponseFromJson(res);
      return reportResponse;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
