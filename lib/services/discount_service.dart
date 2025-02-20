import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/discount_list_response.dart';
import 'package:vet_pharma/model/discount_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class DiscountService {
  static Future<dynamic> addDiscount(DiscountRequest discountRequest) async {
    var token = await StorageUtil.getValue("token");

    final response = await http.post(Uri.parse(EndPoints.Discount),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
        body: discountRequestToJson(discountRequest));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add discount');
    }
  }

  static Future<dynamic> fetchDiscount() async {
    var token = await StorageUtil.getValue("token");
    var headers = {
      "Access-Control-Allow-Origin": "*",
      'Accept': "*/*",
      'Authorization': "Bearer $token"
    };
    final response =
        await http.get(Uri.parse(EndPoints.Discount), headers: headers);

    if (response.statusCode == 200) {
      List<DiscountListResponse> responseList = [];
      var res = handleResponse(response);
      if (res != null) {
        for (var element in jsonDecode(res)) {
          DiscountListResponse discountListResponse =
              DiscountListResponse.fromJson(element);
          responseList.add(discountListResponse);
        }
        return responseList;
      } else {
        return;
      }
    } else {
      throw Exception('Failed to load discount');
    }
  }


  static Future<dynamic> updateDiscount(discountListResponse ,int id) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse("${EndPoints.Discount_Update}${id}");
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response = await http.put(uri,
          headers: headers,
          body: discountRequestToJson(discountListResponse));

      var res=handleResponse(response);
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
