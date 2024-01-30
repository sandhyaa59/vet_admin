import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/bill_details_response.dart';
import 'package:vet_pharma/model/bill_repsonse.dart';
import 'package:vet_pharma/model/bill_save_response.dart';
import 'package:vet_pharma/model/pagination_request.dart';

import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class BillService {
  static Future<dynamic> billList(PaginationRequest request) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse('${EndPoints.BILL_LIST}?page=${request.page}&pageSize=${request.pageSize}');
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };

      var response = await http.get(
        uri,
        headers: headers,
      );
      var res = handleResponse(response);
     if(res!=null){
       BillResponse billResponse = billResponseFromJson(res);
      return billResponse;
     }

     else{
      return;
     }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> billDetails(int id) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse("${EndPoints.BILL_DETAILS}/$id");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.get(uri, headers: headers);
      var res = handleResponse(response);
      if(res!=null){
        BillDetailsResponse billResponse = billDetailsResponseFromJson(res);
      return billResponse;
      }
      else{
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> addBill(BillAddRequest addRequest) async {
    try {
      Uri uri = Uri.parse(EndPoints.BILL_SAVE);
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.post(uri,
          headers: headers, body: billAddRequestToJson(addRequest));
      var res = handleResponse(response);
      if(res!=null){
        return res;
      }
      else{
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> billCancel(int id) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse("${EndPoints.BILL_CANCEL}${id}");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };

      var response = await http.get(uri, headers: headers);
       var res = handleResponse(response);
      if(res!=null){
        return res;
      }
      else{
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
