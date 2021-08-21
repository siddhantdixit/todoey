import 'package:flutter/cupertino.dart';
import 'package:todoey_flutter/models/task_item.dart';
import 'package:todoey_flutter/task_tile.dart';

import 'models/DatabaseHelper.dart';

class TaskList extends StatefulWidget {
  TaskList({required this.myTasks, required this.taskUpdate});

  final Function taskUpdate;

  List<TaskItem> myTasks;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  // List<TaskItem> mytask = [
  //   TaskItem(taskString: "Buy Mango"),
  //   TaskItem(taskString: "Buy People"),
  //   TaskItem(taskString: "Buy Choco"),
  // ];

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: [
    //     TaskTile(),
    //     TaskTile(),
    //     TaskTile(),
    //   ],
    // );
    if (widget.myTasks.length == 0) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          'No Tasks for Today.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return TaskTile(
            myTsk: widget.myTasks[index],
            deleteCallback: (deleteTask) {
              // print(deleteTask);
              setState(() {
                widget.myTasks.remove(deleteTask);
                widget.taskUpdate();
              });

              TaskDatabase.instance.delete(deleteTask.id);

            },
          );
        },
        itemCount: widget.myTasks.length,
      );
    }
  }
}
