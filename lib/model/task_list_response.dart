// To parse this JSON data, do
//
//     final taskListResponse = taskListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:vet_pharma/utils/helper.dart';

TaskListResponse taskListResponseFromJson(String str) {
    final jsonData = json.decode(str);
    return TaskListResponse.fromJson(jsonData);
}

String taskListResponseToJson(TaskListResponse data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class TaskListResponse {
    List<TaskList>? data;
    int? totalPage;
    int? totalData;
    int? pageNumber;
    bool? hasNext;

    TaskListResponse({
        this.data,
        this.totalPage,
        this.totalData,
        this.pageNumber,
        this.hasNext,
    });

    factory TaskListResponse.fromJson(Map<String, dynamic> json) =>  TaskListResponse(
        data:  List<TaskList>.from(json["data"].map((x) => TaskList.fromJson(x))),
        totalPage: json["totalPage"],
        totalData: json["totalData"],
        pageNumber: json["pageNumber"],
        hasNext: json["hasNext"],
    );

    Map<String, dynamic> toJson() => {
        "data":  List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalPage": totalPage,
        "totalData": totalData,
        "pageNumber": pageNumber,
        "hasNext": hasNext,
    };
}

class TaskList {
    int? id;
    String? status;
    String? task;
    String? addedDateTime;
    dynamic modifiedAt;
    String? employeeName;
    String? employeeEmail;

    TaskList({
        this.id,
        this.status,
        this.task,
        this.addedDateTime,
        this.modifiedAt,
        this.employeeName,
        this.employeeEmail,
    });

    factory TaskList.fromJson(Map<String, dynamic> json) =>  TaskList(
        id: json["id"],
        status: json["status"],
        task: json["task"],
        addedDateTime:convertTimeStamp( json["addedDateTime"]),
        modifiedAt: json["modifiedAt"],
        employeeName: json["employeeName"],
        employeeEmail: json["employeeEmail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "task": task,
        "addedDateTime": addedDateTime,
        "modifiedAt": modifiedAt,
        "employeeName": employeeName,
        "employeeEmail": employeeEmail,
    };
}
