import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_pharma/model/bill_repsonse.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/payment_repsone.dart';
import 'package:vet_pharma/model/payment_save_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';
import 'package:http/http.dart' as http;

class PaymentServices {
  static Future<dynamic> getPaymentList(PaginationRequest request) async {
    try {
      Uri uri = Uri.parse(
          "${EndPoints.PAYMENT_LIST}?page=${request.page}&pageSize=${request.pageSize}");
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };

      var response = await http.get(uri, headers: headers);
      var res = handleResponse(response);
      if (res != null) {
        PaymentListResponse paymentListResponse =
            paymentListResponseFromJson(res);
        return paymentListResponse;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> savePaymentList(
      PaymentSaveRequest paymentSaveRequest) async {
    try {
      Uri uri = Uri.parse(EndPoints.PAYMENT_LIST);
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.post(uri,
          headers: headers, body: paymentSaveRequestToJson(paymentSaveRequest));
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

  static Future<dynamic> searchBill(String keyword) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse("${EndPoints.BILL_SEARCH}${keyword}");
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
        List<Bill> billLists = <Bill>[];
        for (var element in jsonDecode(res)) {
          Bill bills = Bill.fromJson(element);
          billLists.add(bills);
        }
        return billLists;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
