import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/customer_add_request.dart';
import 'package:vet_pharma/model/customer_list_response.dart';
import 'package:vet_pharma/model/customer_update_request.dart';
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class CustomerService {
  static Future<dynamic> customerList(PaginationRequest request) async {
    try {
      var token = await StorageUtil.getValue("token");
      Uri uri = Uri.parse(
          "${EndPoints.CUSTOMER_LIST}?page=${request.page}&pageSize=${request.pageSize}");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.get(uri, headers: headers);
      var res = handleResponse(response);
      if (res != null) {
        CustomerListResponse customerListResponse =
            customerListResponseFromJson(res);
        return customerListResponse;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<dynamic> activateCustomer(int id) async {
    try {
      Uri uri = Uri.parse("${EndPoints.CUSTOMER_ACTIVATE}${id}");
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

  static Future<dynamic> deactivateCustomer(int id) async {
    try {
      Uri uri = Uri.parse("${EndPoints.CUSTOMER_DEACTIVATE}${id}");
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

  static Future<dynamic> deleteCustomer(int id) async {
    try {
      Uri uri = Uri.parse("${EndPoints.CUSTOMER_DDELETE}${id}");
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

  static Future<dynamic> addCustomer(CustomerAddRequest addRequest) async {
    try {
      Uri uri = Uri.parse(EndPoints.CUSTOMER_ADD);
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.post(uri,
          headers: headers, body: customerAddRequestToJson(addRequest));
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

  static Future<dynamic> updateCustomer(
      CustomerUpdateRequest updateRequest) async {
    try {
      Uri uri = Uri.parse(EndPoints.CUSTOMER_UPDATE);
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      var response = await http.post(uri,
          headers: headers, body: customerUpdateRequestToJson(updateRequest));
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
