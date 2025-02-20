import 'dart:convert';
// import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
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

   static Future<dynamic> downloadCustomerData(
      ) async {
    try {
      Uri uri = Uri.parse(EndPoints.CUSTOMER_DOWNLOAD);
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      // Directory tempDir = await getApplicationDocumentsDirectory();
      //   String savePath = '${tempDir.path}/customers.xlsx';
      var response = await http.get(uri,
          headers: headers, );
      var res = handleResponse(response);
      if (res != null) {
       final bytes = response.bodyBytes;
        // final blob = html.Blob([bytes]);
        // final url = html.Url.createObjectUrlFromBlob(blob);
        // final anchor = html.AnchorElement(href: url)
        //   ..setAttribute("download", "customers.xlsx")
        //   ..click();
        // html.Url.revokeObjectUrl(url);
        return res;
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  
   static Future<dynamic> uploadCustomerData(BuildContext context,
      PlatformFile platformFile) async {
    try {
      Uri uri = Uri.parse(EndPoints.CUSTOMER_UPLOAD);
      var token = await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization': "Bearer $token"
      };
      // File selectedFile = File(platformFile.path!);
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
        request.files.add(await http.MultipartFile.fromBytes('file', platformFile.bytes??Uint8List(0),filename: "file"));

  var response = await request.send();
      // var res = handleResponse(response.);
     if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File uploaded successfully")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload failed")));
        }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
