import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/login_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';
class LoginService {

static Future<dynamic> doLogin(String email,password)async{

try {
  Uri uri=Uri.parse(EndPoints.LOGIN);
   var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*"
      };
     
       LoginRequest request = LoginRequest(userName: email, password: password);
      var response = await http.post(uri,
          body: loginRequestToJson(request), headers: headers);
           StorageUtil.saveValue("token", json.decode(response.body)["token"]);
 return handleResponse(response);
} catch (e) {
  
}
}


}