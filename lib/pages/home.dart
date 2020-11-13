import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/Database.dart';
import 'package:myapp/TodoModel.dart';

import 'dart:math' as math;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<Todo>>(
        future: DBProvider.db.getNotDoneTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Todo item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.grey[600]),
                  onDismissed: (direction) async {
                    await DBProvider.db.deleteTodo(item.id);
                    setState((){});
                    final snackbar = SnackBar(content: Text("Deleted Todo"));
                    Scaffold.of(context).showSnackBar(snackbar);
                  },
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/todo', arguments: {
                      'id': item.id,
                      'title':item.title,
                      'description':item.description,
                      'isDone': item.isDone,
                    }),
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
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
                                final snackbar = SnackBar(content: Text("Added Todo to Done"));
                                Scaffold.of(context).showSnackBar(snackbar);
                              },
                              value: item.isDone,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    item.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
