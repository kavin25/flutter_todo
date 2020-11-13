import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/Database.dart';
import 'package:myapp/TodoModel.dart';

import 'dart:math' as math;

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Todo> testTodos = [
    Todo(title: "Go to market", description: "Buy vegetables", isDone: false),
    Todo(title: "Homework", description: "Maths Assignment", isDone: false),
    Todo(title: "Programming", description: "Posting API", isDone: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text("Todo App"),),
      backgroundColor: Color(0xFFd6d6dc),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
              "Todos",
              style: TextStyle(
                fontSize: 30,
              ),
          ),
          Container(
            child: FutureBuilder<List<Todo>>(
              future: DBProvider.db.getAllTodos(),
              builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Todo item = snapshot.data[index];
//                return ListTile(
//                  title: Text(item.title),
//                  leading: Text(item.id.toString()),
//                  trailing: Checkbox(
//                    onChanged: (bool value) {
//                      DBProvider.db.doneOrUndone(item);
//                      setState(() {});
//                    },
//                    value: item.isDone,
//                  ),
//                );
                      return Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                onChanged: (bool value) {
                                  DBProvider.db.doneOrUndone(item);
                                  setState(() {});
                                },
                                value: item.isDone,
                              )
                            ],
                          )
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Todo rnd = testTodos[math.Random().nextInt(testTodos.length)];
          await DBProvider.db.newTodo(rnd);
          setState(() {});
        },
      ),
    );
  }
}
