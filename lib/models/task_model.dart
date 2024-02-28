import 'package:todo_app/models/task_status.dart';

class TaskModel {
  final int? id;
  final String title;
  final String description;
  final String category;
  final DateTime deadline;
  final int priority;
  final TaskStatus status;

  TaskModel({
    this.id,
    required this.description,
    required this.title,
    required this.category,
    required this.deadline,
    required this.priority,
    required this.status,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    DateTime? deadline,
    int? priority,
    TaskStatus? status,
  }) {
    return TaskModel(
        description: description ?? this.description,
        title: title ?? this.title,
        category: category ?? this.category,
        deadline: deadline ?? this.deadline,
        priority: priority ?? this.priority,
        status: status ?? this.status);
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        description: json["description"] as String ?? "",
        title: json["title"] as String ?? "",
        category: json["category"] as String ?? "",
        deadline: DateTime.parse(
          json["deadline"] as String ?? "",
        ),
        priority: json["priority"] as int ?? 1,
        status: getStatus(json["status"]),
        id: json["_id"] as int? ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "title": title,
      "category": category,
      "deadline": deadline.toString(),
      "priority": priority,
      "status": status.name,
    };
  }

  bool canAddTaskToDatabase(){
    if(title.isEmpty) return false;
    if(description.isEmpty) return false;
    if(category.isEmpty) return false;
    if(priority==0) return false;
    return true;
  }

  static TaskModel initialValue = TaskModel(
      description: "",
      title: "",
      category: "",
      deadline: DateTime.now(),
      priority: 1,
      status: TaskStatus.processing);
}

TaskStatus getStatus(String statusText) {
  switch (statusText) {
    case "processing":
      {
        return TaskStatus.processing;
      }
    case "done":
      {
        return TaskStatus.done;
      }
    case "canceled":
      {
        return TaskStatus.canceled;
      }

    default:
      {
        return TaskStatus.missed;
      }
  }
}
