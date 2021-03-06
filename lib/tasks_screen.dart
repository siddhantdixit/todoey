import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todoey_flutter/add_task.dart';
import 'package:todoey_flutter/models/DatabaseHelper.dart';
import 'package:todoey_flutter/task_list.dart';

import 'models/task_item.dart';

final bgColor = Color(0xFF63C9FE);

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskItem> myTasks = [];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllNotes();
  }

  void printMyTasks()
  {
    for(TaskItem x in this.myTasks)
      {
        print("\n\n");
        print(x.id);
        print(x.taskString);
        print(x.isDone);
      }
  }

  Future getAllNotes() async {
    // setState(() => isLoading = true);
    setState(() {
      isLoading = true;
    });

    this.myTasks = await TaskDatabase.instance.readAllNotes();

    // print(myTasks);
    printMyTasks();


    setState(() {
      this.noOfTasks = myTasks.length;
      isLoading = false;
    });
    // this.notes = await NotesDatabase.instance.readAllNotes();

    // setState(() => isLoading = false);
  }

  int noOfTasks = 0;

  // List<TaskItem>  myTasks = [
  //   TaskItem(taskString: "Buy Mango"),
  //   TaskItem(taskString: "Buy People"),
  //   TaskItem(taskString: "Buy Choco"),
  // ];

  bool isDone = false;

  Future<TaskItem> addNote(String taskData) async {
    final note = TaskItem(
      taskString: taskData,
      isDone: false,
    );
    return await TaskDatabase.instance.create(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTaskScreen((newTaskTitle) async {
                      print(newTaskTitle);
                      TaskItem newTsk = await addNote(newTaskTitle);
                      setState(() {
                        myTasks.add(newTsk);
                        // addNote(newTaskTitle);
                      });
                    }))),
          );
        },
        backgroundColor: bgColor,
        child: Icon(Icons.add),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.list, color: bgColor, size: 35),
                      ),
                    ),
                    Text(
                      'Todoey',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${myTasks.length} Tasks',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: (isLoading == true)
                  ? Container(
                      child: Text(
                        'Loading ... ',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      alignment: Alignment.center,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                        // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 80.0),
                        child: TaskList(
                          myTasks: myTasks,
                          taskUpdate: () {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// class TaskList extends StatefulWidget {
//   @override
//   _TaskListState createState() => _TaskListState();
// }
//
// class _TaskListState extends State<TaskList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         TaskTile(),
//         TaskTile(),
//         TaskTile(),
//       ],
//     );
//   }
// }
//
// class TaskTile extends StatefulWidget {
//   @override
//   _TaskTileState createState() => _TaskTileState();
// }
//
// class _TaskTileState extends State<TaskTile> {
//   bool isChecked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         'Buy Choco',
//         style: TextStyle(
//           fontSize: 20,
//             decoration:
//                 isChecked ? TextDecoration.lineThrough : TextDecoration.none),
//       ),
//       trailing: Checkbox(
//           value: isChecked,
//           onChanged: (mych) {
//             setState(() {
//               isChecked = mych!;
//             });
//           }),
//     );
//   }
// }
