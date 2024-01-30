import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/login_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class LoginService {
  static Future<dynamic> doLogin(String email, password) async {
    try {
      Uri uri = Uri.parse(EndPoints.LOGIN);
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*"
      };

      LoginRequest request = LoginRequest(userName: email, password: password);
      var response = await http.post(uri,
          body: loginRequestToJson(request), headers: headers);
      var res= handleResponse(response);
      if(res!=null){
StorageUtil.saveValue("token", json.decode(response.body)["token"]);
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
