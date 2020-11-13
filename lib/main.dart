import 'package:flutter/material.dart';
import 'package:myapp/pages/done.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/mainScreen.dart';
import 'package:myapp/pages/todo.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Color(0xFFF66666),
    ),
  initialRoute: '/',
  routes: {
      '/': (context) => MainScreen(),
    '/todo': (context) => TodoScreen(),
  },
));

