import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/DatabaseHelper.dart';
import 'package:todoey_flutter/models/task_item.dart';

class TaskTile extends StatefulWidget {

  // TaskTile({required this.taskText,this.isChecked=false});
  //
  // String taskText;
  // bool isChecked;
  TaskTile({required this.myTsk,required this.deleteCallback});

  final Function deleteCallback;

  TaskItem myTsk;

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        widget.deleteCallback(widget.myTsk);
      },
      title: Text(
        widget.myTsk.taskString,
        style: TextStyle(
            fontSize: 20,
            decoration:
            widget.myTsk.isDone ? TextDecoration.lineThrough : TextDecoration.none),
      ),
      trailing: Checkbox(
          value: widget.myTsk.isDone,
          onChanged: (mych) {
            setState(() {
              widget.myTsk.isDone = mych!;
            });
            // updateNote(widget.myTsk.id);
            print("ID of the object = ${widget.myTsk.id}");
            TaskDatabase.instance.setNoteDone(widget.myTsk.id, widget.myTsk.isDone);
          }),
    );
  }


  // Future updateNote(int Noteid) async {
  //   await TaskDatabase.instance.setNoteDone(myNoteid, widget.myTsk.isDone);
  // }
}

