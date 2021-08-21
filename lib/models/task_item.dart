import 'package:flutter/material.dart';

final String tabletasks = 'tasksdata';

class TasksFields {
  static final List<String> values = [
    /// Add all fields
    id,taskDesc,isDone
  ];

  static final String id = 'id';
  static final String isDone = 'done';
  static final String taskDesc = 'task';
}

class TaskItem
{
  TaskItem({this.id,required this.taskString,this.isDone=false});

  final int? id;

  String taskString;

  bool isDone;



  TaskItem copy({
    int? id,
    String? taskString,
    bool? isDone
  }) =>
      TaskItem(
        id: id ?? this.id,
        taskString: taskString ?? this.taskString,
        isDone: isDone ?? this.isDone,
      );


  static TaskItem fromJson(Map<String, Object?> json) => TaskItem(
    id: json[TasksFields.id] as int?,
    taskString: json[TasksFields.taskDesc] as String,
    isDone: json[TasksFields.isDone] == '1',
  );

  Map<String, Object?> toJson() => {
    TasksFields.id: id,
    TasksFields.taskDesc: taskString,
    TasksFields.isDone: isDone?1:0
  };
}