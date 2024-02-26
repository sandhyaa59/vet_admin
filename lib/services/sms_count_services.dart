

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/customer_list_response.dart';
import 'package:vet_pharma/model/sms_Count_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class SmsCountServices {
  static Future<dynamic> sendSms(SmsCountRequest smsCountRequest) async {
    try {
      Uri uri = Uri.parse(EndPoints.SMS);
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.post(uri,
          headers: headers, body: smsCountRequestToJson(smsCountRequest));
      var res = handleResponse(response);

      if (res != null) {
        return res;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  static Future<dynamic> searchCustomer(String keyword) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse("${EndPoints.CUSTOMER_SEARCH}${keyword}");
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response = await http.get(
        uri,
        headers: headers,
      );
      var res = handleResponse(response);
      if (res != null) {
        CustomerListResponse  customerListResponse=CustomerListResponse.fromJson(jsonDecode(res));
        return customerListResponse;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
