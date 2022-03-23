import 'package:flutter/cupertino.dart';

class Task{
  Task(this.id, this.title, this.check, this.focusNode);

  int id;
  String title;
  bool check;
  FocusNode focusNode;
}