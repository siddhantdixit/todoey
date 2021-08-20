import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/task_item.dart';

class AddTaskScreen extends StatefulWidget {
  final Function addTaskCallBack;

  AddTaskScreen(this.addTaskCallBack);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTaskText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          children: [
            Text(
              'Add Task',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 30.0),
            TextField(
              onChanged: (value) {
                newTaskText = value;
              },
              decoration: InputDecoration(hintText: 'Enter the task'),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
                onPressed: () {
                  if(newTaskText!="")
                    {
                      widget.addTaskCallBack(newTaskText);
                      Navigator.pop(context);
                    }
                },
                child: Text('Add Task')),
            SizedBox(height: 30.0),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0)),
            color: Colors.white),
      ),
    );
  }
}
