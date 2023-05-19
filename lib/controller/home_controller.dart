import 'package:flutter/material.dart';

class HomeController {
  TextEditingController textEditingController = TextEditingController();
  List<String> todoList = [];
  List<bool> todoCompletedList = [];

  void addTodo() {
    String newTodo = textEditingController.text;
    todoList.add(newTodo);
    todoCompletedList.add(false);
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
    final completed = todoCompletedList.removeAt(oldIndex);
    todoList.insert(newIndex, item);
    todoCompletedList.insert(newIndex, completed);
  }

  void compleList(int index) {
    todoCompletedList[index] = !todoCompletedList[index]; // 클릭된 체크박스의 완료 여부 반전
  }
}
