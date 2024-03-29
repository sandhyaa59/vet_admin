import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/organization_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';


class OrganizationServices{

  static Future<dynamic> getOrganizationList()async{

    try {
       var token=await StorageUtil.getValue("token");
      Uri uri=Uri.parse(EndPoints.ORGANIZATION_LIST);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };  var response=await http.get(uri,headers: headers,);
        var res=handleResponse(response);
        return res;
    }
    catch(e){
      debugPrint(e.toString());
    }
  }

}