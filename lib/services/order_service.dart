import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:vet_pharma/model/order_response.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';
class OrderService{

 static Future<dynamic> orderList(PaginationRequest request)async{

try {
  var token=await StorageUtil.getValue("token");
  Uri uri=Uri.parse("${EndPoints.ORDERLIST}?page=${request.page}&pageSize=${request.pageSize}");
   var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };
     
       
      var response = await http.get(uri,
          headers: headers);
           var res= handleResponse(response);
           if(res!=null){
            OrderResponse checkInOutResponse=orderResponseFromJson(res);
 return checkInOutResponse;
           }
           else{
            return;
           }
} catch (e) {
  debugPrint(e.toString());
}
}


static Future<dynamic> orderCancel(int id)async{
try {
  var token=await StorageUtil.getValue("token");
  Uri uri=Uri.parse("${EndPoints.ORDER_CANCEL}${id}");
   var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };
     
       
      var response = await http.get(uri,
          headers: headers);
           var res= handleResponse(response);
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