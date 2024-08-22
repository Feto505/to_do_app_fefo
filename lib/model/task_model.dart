import 'package:todo_app/core/utils.dart';

class TaskModel {
  static const String collectionName = "TasksCollection";
  String? id;
  String title;
  String description;
  DateTime selectedDate;
  bool isDone;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.selectedDate,
    this.isDone = false,
  });

  factory TaskModel.fromJSON(Map<String, dynamic> json) {
    return TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        // selectedDate: DateTime.parse(json["selectedDate"]),
        selectedDate: DateTime.fromMillisecondsSinceEpoch(json["selectedDate"]),
        isDone: json["isDone"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      // "selectedDate":selectedDate.toIso8601String(),//wrong
      "selectedDate": extractDate(selectedDate).millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }
}
