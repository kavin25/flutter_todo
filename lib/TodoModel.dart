// To parse this JSON data, do
//
//     final todo = todoFromMap(jsonString);

import 'dart:convert';

Todo todoFromMap(String str) => Todo.fromMap(json.decode(str));

String todoToMap(Todo data) => json.encode(data.toMap());

class Todo {
  Todo({
    this.id,
    this.title,
    this.description,
    this.isDone,
  });

  int id;
  String title;
  String description;
  bool isDone;

  factory Todo.fromMap(Map<String, dynamic> json) => new Todo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    isDone: json["isDone"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "isDone": isDone,
  };
}
