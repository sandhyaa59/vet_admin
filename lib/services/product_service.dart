import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/product_list_response.dart';
import 'package:vet_pharma/model/productadd_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class ProductService {
  static Future<dynamic> getProductList(PaginationRequest request) async {
    try {
      Uri uri = Uri.parse(
          "${EndPoints.Product}?page=${request.page}&?pageSize=${request.pageSize}");
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };

      var response = await http.get(uri, headers: headers);
      var res = handleResponse(response);
      if (res != null) {
        ProductListResponse productListResponse =
            productListResponseFromJson(res);
        return productListResponse;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> addProduct(ProductAddRequest addRequest) async {
    try {
      Uri uri = Uri.parse(EndPoints.Product_Add);
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.post(uri,
          headers: headers, body: productAddRequestToJson(addRequest));
      var res = handleResponse(response);
      if (res != null) {
        return res;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> updateProduct(ProductAddRequest productUpdate) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse(EndPoints.Product_update);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'authorization': 'Bearer $token'
      };
      var response = await http.post(uri,
          headers: headers, body: productAddRequestToJson(productUpdate));

      var res = handleResponse(response);
      if (res != null) {
        return res;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> activateProduct(int id) async {
    try {
      Uri uri = Uri.parse("${EndPoints.product_activate}${id}");
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };

      var response = await http.get(uri, headers: headers);
      var res = handleResponse(response);
      if (res != null) {
        return res;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> deactivateProduct(int id) async {
    try {
      Uri uri = Uri.parse("${EndPoints.product_deactivate}${id}");
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.get(uri, headers: headers);
      var res = handleResponse(response);
      if (res != null) {
        return res;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
