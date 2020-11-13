import 'dart:io';
import 'dart:async';

import 'package:myapp/TodoModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      print("Not null database");
      return _database;
    } else {
      print("Databae is null");
      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    print("Init DB called");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Todo ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "isDone BOOLEAN"
          ")");
      });
  }

  newTodo(Todo newTodo) async {
    print("hello creating");
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Todo");
    print(table);
    int id = table.first["id"];
    // insert into table
    var raw = await db.rawInsert(
      "INSERT into Todo (id, title, description, isDone)"
          " Values (?,?,?,?)",
      [id, newTodo.title, newTodo.description, newTodo.isDone]);
    print(raw);
    return raw;
  }

  getTodo(int id) async {
    final db = await database;
    var res = await db.query("Todo", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Todo.fromMap(res.first) : Null ;
  }

  Future<List<Todo>> getAllTodos() async {
    print("getting all todos");
    final db = await database;
    var res = await db.query("Todo");
    print(res);
    print(res.isNotEmpty);
    res.map((c) => print(Todo.fromMap(c)));
    List<Todo> list =
    res.isNotEmpty ? res.map((c) => Todo.fromMap(c)).toList() : [];
    print("******");
    print(list);
    return list;
  }

  Future<List<Todo>> getDoneTodos() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Todo WHERE isDone=1");
    List<Todo> list = res.isNotEmpty ? res.map((e) => Todo.fromMap(e)).toList() : [];
    return list;
  }

  Future<List<Todo>> getNotDoneTodos() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Todo WHERE isDone=0");
    List<Todo> list = res.isNotEmpty ? res.map((e) => Todo.fromMap(e)).toList() : [];
    return list;
  }

  doneOrUndone(Todo todo) async {
    final db = await database;
    Todo done = Todo(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isDone: !todo.isDone
    );
    var res = await db.update("Todo", done.toMap(), where: "id = ?", whereArgs: [todo.id]);
    return res;
  }

  deleteTodo(int id) async {
    final db = await database;
    db.delete("Todo", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Todo");
  }
}
