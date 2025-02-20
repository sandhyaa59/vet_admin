import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/category.dart';
import 'package:vet_pharma/model/category_list_response.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class CategoryService {
  

  Future<bool> addCategory(CategoryRequest cat) async {
          var token = await StorageUtil.getValue("token");

    final response = await http.post(
      Uri.parse(EndPoints.AddCategory),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
         'Authorization': "Bearer $token"
      },
      body: categoryRequestToJson(cat)
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add category');
    }
  }

  Future<bool> addSubCategory(String title, String description, int parentCategoryId) async {
    final response = await http.post(
      Uri.parse(EndPoints.AddCategory),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'description': description,
        'parentCategory': parentCategoryId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add subcategory');
    }
  }

  Future<dynamic> fetchCategories() async {
    var token=await StorageUtil.getValue("token");
     var headers = {
        "Access-Control-Allow-Origin": "*",
       
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };
    final response = await http.get(Uri.parse(EndPoints.CategoryOnly),headers: headers);

   if (response.statusCode == 200) {
    List<CategoryListResponse> responseList=[];
    var res= handleResponse(response);
           if(res!=null){
            for (var element in jsonDecode(res)) {
        CategoryListResponse categoryListResponse=CategoryListResponse.fromJson(element);
        responseList.add(categoryListResponse);
    }
 return responseList;
           }
           else{
            return;
           }
    
    
    } else {
      throw Exception('Failed to load categories');
    }
  }
   
  



  static Future<dynamic> activateCategory(int id) async {
    try {
      Uri uri = Uri.parse("${EndPoints.Category_Activate}${id}");
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };

      var response = await http.get(uri, headers: headers);
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

  static Future<dynamic> deactivateCategory(int id) async {
    try {
      Uri uri = Uri.parse("${EndPoints.Category_Deactivate}${id}");
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.get(uri, headers: headers);
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

 

  static Future<dynamic> updateCategory(updatecategory) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse(EndPoints.Category_Update);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response = await http.post(uri,
          headers: headers,
          body: categoryListResponseToJson(updatecategory));

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
