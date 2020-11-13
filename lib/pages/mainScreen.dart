import 'package:flutter/material.dart';
import 'package:myapp/Database.dart';
import 'package:myapp/TodoModel.dart';
import 'package:myapp/pages/done.dart';
import 'package:myapp/pages/home.dart';
import 'dart:math' as math;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;

  Widget getPage() {
    switch(_page) {
      case 0:
        return Home();
        break;
      case 1:
        return Done();
        break;
    }
  }

  bool getIsVisible() {
    if (_page == 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    List<Todo> testTodos = [
      Todo(title: "Go to market", description: "Buy vegetables", isDone: false),
      Todo(title: "Homework", description: "Maths Assignment which is very very very very very very very very very very very very very", isDone: false),
      Todo(title: "Programming", description: "Posting API", isDone: false),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFd6d6dc),
      body: getPage(),
      appBar: AppBar(
        title: Text(
          "Todo App",
//          style: TextStyle(
//            color: Colors.black,
//          ),
        ),
//        backgroundColor: Color(0xFFd6d6dc),
//        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          onTap: (value) {
            setState(() {
              _page=value;
            });
          },
          items: [
            BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text("Done"),
              icon: Icon(Icons.check_circle_outline),
            ),
          ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: getIsVisible(),
        child: FloatingActionButton(
          elevation: 0.0,
          child: Icon(Icons.add),
          onPressed: () async {
            Todo rnd = testTodos[math.Random().nextInt(testTodos.length)];
            await DBProvider.db.newTodo(rnd);
            setState(() {});
            String text = "Added Todo";
          },
        ),
      ),
    );
  }
}
