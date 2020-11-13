import 'package:flutter/material.dart';
import 'package:myapp/Database.dart';
import 'package:myapp/TodoModel.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  Map data = {};
  Icon icon;
  bool _isDone;


  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
        ),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              data['title'],
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,),
            Text(data['description']),
            SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }
}
