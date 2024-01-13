import 'package:flutter/material.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/payment_repsone.dart';
import 'package:vet_pharma/model/payment_save_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';
import 'package:http/http.dart' as http;


class PaymentServices{

static  Future<dynamic> getPaymentList(PaginationRequest request)async{

    try {
      Uri uri=Uri.parse("${EndPoints.PAYMENT_LIST}?page=${request.page}&pageSize=${request.pageSize}");
      var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };

      var response=await http.get(uri,headers: headers);
      var res=handleResponse(response);
      PaymentListResponse paymentListResponse=paymentListResponseFromJson(res);
      return paymentListResponse;
    
  } catch (e) {
      debugPrint(e.toString());
  }
  }


static  Future<dynamic> savePaymentList(PaymentSaveRequest paymentSaveRequest)async{

     try {
     Uri uri=Uri.parse(EndPoints.PAYMENT_LIST);
 var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };
      var response=await http.post(uri,headers: headers,
      body: paymentSaveRequestToJson(paymentSaveRequest));
    var res=handleResponse(response);
    return res;
 
  } catch (e) {
     debugPrint(e.toString());
  }
  }
}