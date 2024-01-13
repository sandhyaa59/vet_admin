import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/check_in_out_response.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';
class CheckInOutService{
  static Future<dynamic> checkinoutList(PaginationRequest request)async{

try {
  var token=await StorageUtil.getValue("token");
  Uri uri=Uri.parse("${EndPoints.CHECKINOUTLIST}?page=${request.page}&pageSize=${request.pageSize}");
   var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };
     
       
      var response = await http.get(uri,
          headers: headers);
           var res= handleResponse(response);
           CheckInOutResponse checkInOutResponse=checkInOutResponseFromJson(res);
         
 return checkInOutResponse;
} catch (e) {
  debugPrint(e.toString());
}
}
}