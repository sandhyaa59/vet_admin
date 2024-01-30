import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vet_pharma/model/pagination_request.dart';
import 'package:vet_pharma/model/save_task_request.dart';
import 'package:vet_pharma/model/task_list_response.dart';
import 'package:vet_pharma/utils/endpoints.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/utils/local_storage.dart';

class TaskServices{

 static Future<dynamic>saveTask(SaveTaskRequest saveTaskRequest)async{
    try {
       Uri uri=Uri.parse(EndPoints.SAVE_TASK);
 var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };
      var response=await http.post(uri,headers: headers,
      body: saveTaskRequestToJson(saveTaskRequest));
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



static Future<dynamic>taskList(PaginationRequest request)async{

  try {
    Uri uri=Uri.parse("${EndPoints.TASK_LIST}?page=${request.page}&?pageSize=${request.pageSize}");
     var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };

      var response=await http.get(uri,headers: headers);
      var res=handleResponse(response);
      if(res!=null){
        TaskListResponse taskListResponse=taskListResponseFromJson(res);
      return taskListResponse;
      }
      else{
        return;
      }
  } catch (e) {
      debugPrint(e.toString());
  }
}



static Future<dynamic> updateTask(String status, int id)async{
  try {
     Uri uri=Uri.parse("${EndPoints.TASK_UPDATE}/${status}/${id}");
 var token=await StorageUtil.getValue("token");
      var headers = {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': "*/*",
        'Authorization':"Bearer $token"
      };
      var response=await http.get(uri,headers: headers);
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