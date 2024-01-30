// To parse this JSON data, do
//
//     final saveTaskRequest = saveTaskRequestFromJson(jsonString);

import 'dart:convert';

SaveTaskRequest saveTaskRequestFromJson(String str) {
    final jsonData = json.decode(str);
    return SaveTaskRequest.fromJson(jsonData);
}

String saveTaskRequestToJson(SaveTaskRequest data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class SaveTaskRequest {
    String ?task;
    int? id;

    SaveTaskRequest({
        this.task,
        this.id,
    });

    factory SaveTaskRequest.fromJson(Map<String, dynamic> json) =>  SaveTaskRequest(
        task: json["task"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "task": task,
        "id": id,
    };
}
