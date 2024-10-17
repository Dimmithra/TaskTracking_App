// To parse this JSON data, do
//
//     final TaskModel = TaskModelFromMap(jsonString);

import 'dart:convert';

TaskModel taskModelFromMap(String str) => TaskModel.fromMap(json.decode(str));

String taskModelToMap(TaskModel data) => json.encode(data.toMap());

class TaskModel {
  final int? taskid;
  final String? title;
  final String? discription;
  final String? taskdate;
  final String? tasktime;

  TaskModel({
    this.taskid,
    this.title,
    this.discription,
    this.taskdate,
    this.tasktime,
  });

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
        taskid: json["taskid"],
        title: json["title"],
        discription: json["discription"],
        taskdate: json["taskdate"],
        tasktime: json["tasktime"],
      );

  Map<String, dynamic> toMap() => {
        "taskid": taskid,
        "title": title,
        "discription": discription,
        "taskdate": taskdate,
        "tasktime": tasktime,
      };
}
