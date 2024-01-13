import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/employee_add_request.dart';
import 'package:vet_pharma/model/employee_management_reponse.dart';
import 'package:vet_pharma/model/employee_update_request.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';
class EmployeeManagementServices{

static Future<dynamic>getEmployeeManagementList(PaginationRequest request)async{

  try {
    Uri uri=Uri.parse("${EndPoints.EMPLOYEEMANAGEMENT_LIST}?page=${request.page}&?pageSize=${request.pageSize}");
     var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };

      var response=await http.get(uri,headers: headers);
      var res=handleResponse(response);
      EmployeeManagementResponse employeeManagementResponse=employeeManagementResponseFromJson(res);
      return employeeManagementResponse;
    
  } catch (e) {
      debugPrint(e.toString());
  }
}

static Future<dynamic>getActiveEmployee()async{

  try {
    Uri uri=Uri.parse(EndPoints.EMPLOYEEMANAGEMENT_ACTIVE_LIST);
     var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };

      var response=await http.get(uri,headers: headers);
      var res=handleResponse(response);
      List<EmployeeDetails> empList=<EmployeeDetails>[];
      for (var element in jsonDecode(res)) {
        EmployeeDetails details=EmployeeDetails.fromJson(element);
        empList.add(details);
      }
    
      return empList;
    
  } catch (e) {
      debugPrint(e.toString());
  }
}

static Future<dynamic> activateEmployee(int id)async{

  try {
     Uri uri=Uri.parse("${EndPoints.EMPLOYEEMANAGEMENT_ACTIVATE}${id}");
 var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };

      var response=await http.get(uri,headers: headers);
     return handleResponse(response);
 
  } catch (e) {
     debugPrint(e.toString());
  }
}



static Future<dynamic> deactivateEmployee(int id)async{
  try {
     Uri uri=Uri.parse("${EndPoints.EMPLOYEEMANAGEMENT_DEACTIVATE}${id}");
 var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };
      var response=await http.get(uri,headers: headers);
     return handleResponse(response);
 
  } catch (e) {
     debugPrint(e.toString());
  }
}



static Future<dynamic> deleteEmployee(int id)async{
  try {
     Uri uri=Uri.parse("${EndPoints.EMPLOYEEMANAGEMENT_DELETE}${id}");
 var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };
      var response=await http.get(uri,headers: headers);
     return handleResponse(response);
 
  } catch (e) {
     debugPrint(e.toString());
  }
}


static Future<dynamic> addEmployee(EmployeeAddRequest addRequest)async{
  try {
     Uri uri=Uri.parse(EndPoints.EMPLOYEEMANAGEMENT_SAVE);
 var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };
      var response=await http.post(uri,headers: headers,
      body: employeeAddRequestToJson(addRequest));
    var res=handleResponse(response);
    return res;
 
  } catch (e) {
     debugPrint(e.toString());
  }
}

  static Future<dynamic> updateEmployee(EmployeeUpdateRequest employeeUpdateRequest)async{
    try{
      
      var token=await StorageUtil.getValue("token");
      Uri uri=Uri.parse(EndPoints.EMPLOYEEMANAGEMENT_UPDATE);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response=await http.post(uri,headers: headers,
      body: employeeUpdateRequestToJson(employeeUpdateRequest));
     
        var res=handleResponse(response);
        return res;
      
    }
    catch(e){
      debugPrint(e.toString());
    }
  }
}