import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_database_example/model/note.dart';
import 'package:todoey_flutter/models/task_item.dart';


class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();

  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasksdatabase.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL DEFAULT 0';

    await db.execute('''
CREATE TABLE $tabletasks ( 
  ${TasksFields.id} $idType, 
  ${TasksFields.taskDesc} $textType,
  ${TasksFields.isDone} $textType
  )
''');
  }

  Future<TaskItem> create(TaskItem note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tabletasks, note.toJson());
    return note.copy(id: id);
  }

  Future<TaskItem> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tabletasks,
      columns: TasksFields.values,
      where: '${TasksFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TaskItem.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<TaskItem>> readAllNotes() async {
    final db = await instance.database;

    // final orderBy = '${TasksFields.id.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tabletasks);

    return result.map((json) => TaskItem.fromJson(json)).toList();
  }

  Future<int> setNoteDone(int? id,bool newDone) async {
    final db = await instance.database;

    return db.update(
      tabletasks,
      // note.toJson(),
      {
        TasksFields.isDone: (newDone==true)?1:0
      },
      where: '${TasksFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(TaskItem note) async {
    final db = await instance.database;

    return db.update(
      tabletasks,
      note.toJson(),
      where: '${TasksFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tabletasks,
      where: '${TasksFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
