import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/adminList_response.dart';
import 'package:vet_pharma/model/admin_add_request.dart';
import 'package:vet_pharma/model/update_admin_request.dart';
import 'package:vet_pharma/model/view_admin_response.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class AdminService {
  static Future<dynamic> getAllAdmin() async {
    try {
      Uri uri = Uri.parse(EndPoints.ListAdmin);
      var token = await StorageUtil.getValue("token");
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response = await http.get(uri, headers: headers);
      AdminListResponse adminListResponse = AdminListResponse();
      if (response.statusCode == 200) {
        var res = response.body;

        adminListResponse = AdminListResponse.fromJson(jsonDecode(res));
      }
      return adminListResponse;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> addAdmins(AdminAddRequest addRequest) async {
    try {
      var token = await StorageUtil.getValue("token");

      Uri uri = Uri.parse(EndPoints.AdminAdd);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response = await http.post(uri,
          body: adminAddRequestToJson(addRequest), headers: headers);
    
        // ignore: unused_local_variable
        var res = handleResponse(response);
      
      return response.body;
    } catch (e) {
      debugPrint(e.toString());
      showToastMessage(Colors.red, e.toString(), "Error");
    }
  }

  static Future<dynamic> deactivateAdmin(int id) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse("${EndPoints.AdminDeactivate}${id}");
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response = await http.get(uri, headers: headers);
      return handleResponse(response);
    } catch (e) {showToastMessage(Colors.red, e.toString(), "Error");}
  }

  static Future<dynamic> activateAdmin(int id) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse("${EndPoints.AdminActivate}${id}");
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response = await http.get(uri, headers: headers);
      return handleResponse(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> deleteAdmin(int id)async{
    try{
      var token=await StorageUtil.getValue("token");
      Uri uri=Uri.parse("${EndPoints.AdminDelete}${id}");
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response=await http.get(uri,headers: headers);
      
        var res=handleResponse(response);
        return res;
      

    }
    catch(e){
      debugPrint(e.toString());
    }
  }



  static Future<dynamic> viewAdminDetails(id) async {
    try {
      Uri uri = Uri.parse("${EndPoints.ViewAdmin}${id}");
      var token = await StorageUtil.getValue("token");
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response = await http.get(uri, headers: headers);
      ViewAdminResponse viewAdminResponse = ViewAdminResponse();
      
        var res = handleResponse(response);

        viewAdminResponse = ViewAdminResponse.fromJson(jsonDecode(res));
      
      return viewAdminResponse;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

   static Future<dynamic> updateAdmin(UpdateAdminRequest updateAdminRequest)async{
    try{
      
      var token=await StorageUtil.getValue("token");
      Uri uri=Uri.parse(EndPoints.UpdateAdmin);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response=await http.post(uri,headers: headers,
      body: updateAdminRequestToJson(updateAdminRequest));
     
        var res=handleResponse(response);
        return res;
      
    }
    catch(e){
      debugPrint(e.toString());
    }
  }



   static Future<dynamic> searchAdmin(String keyword)async{
    try{
      
      var token=await StorageUtil.getValue("token");
      Uri uri=Uri.parse("${EndPoints.AdminSearch}${keyword}");
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response=await http.post(uri,headers: headers,
     );
     
        var res=handleResponse(response);
        return res;
      
    }
    catch(e){
      debugPrint(e.toString());
    }
  }
}
