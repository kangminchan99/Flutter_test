import 'package:flutter/material.dart';

class HomeController {
  TextEditingController textEditingController = TextEditingController();
  List<String> todoList = [];

  void addTodo() {
    String newTodo = textEditingController.text;
    todoList.add(newTodo);
    textEditingController.clear();
  }

  void delTodo(int index) {
    todoList.removeAt(index);
  }

  void dispose() {
    textEditingController.dispose();
  }

  void reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = todoList.removeAt(oldIndex);
    todoList.insert(newIndex, item);
  }
}
