import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:pai_traning/models/task.dart';

class TaskViewModel extends ChangeNotifier{
  List<Task> _taskList = [];
  UnmodifiableListView<Task> get taskList => UnmodifiableListView(_taskList);

  void createTask(String title){
    final id = _taskList.length + 1;
    _taskList = [...taskList, Task(id, title, false, FocusNode())];
    notifyListeners();
  }

  void updateTask(int id, String title){
    taskList.asMap().forEach((int index, Task task) {
      if(task.id == id){
        _taskList[index].title = title;
      }
    });
    notifyListeners();
  }

  void updateCheck(int id, bool check){
    taskList.asMap().forEach((int index, Task task) {
      if(task.id == id){
        _taskList[index].check = check;
      }
    });
    notifyListeners();
  }

  void deleteTask(int id){
    _taskList = _taskList.where((task) => task.id != id).toList();
    _taskList.asMap().forEach((int index, Task task) {
      _taskList[index].id = index + 1;
    });
    notifyListeners();
  }
}