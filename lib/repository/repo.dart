import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:weather_app/Modules/models/weather_model.dart';

import '../Modules/Todo/models/todo_model.dart';

class Repo {
  // var todoCon = TodoController();
  static Future<WeatherModel> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return WeatherModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  List<TodoModel> todoList = [];
  int id = 1;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtGender = TextEditingController();
  int editId = 0;
  bool isValidateName = false;
  bool isValidateGender = false;
  final todoModel = TodoModel();
  //////invalid gender
  String? get validGender {
    final text = txtGender.text;
    if (text.isEmpty) {
      return 'Please input text';
    }

    return null;
  }

  //////invalid name
  String? get validName {
    final text = txtName.text;
    if (text.isEmpty) {
      return 'Please input text';
    }
    return null;
  }

  addList(bool isEdit, TodoModel model) {
    if (!isEdit) {
      todoList.add(model);
    } else {
      // debugPrint("==${controller.txtName.text.trim()}==");
      // debugPrint("==${controller.txtGender.text.trim()}==");

      for (var element in todoList) {
        if (element.id == editId) {
          element.name = txtName.text.trim();
          element.gender = txtGender.text.trim();
        }
      }

      isEdit = false;
    }
  }

  ///new add to list
  addtoList(TodoModel model) {
    todoList.add(model);
  }

  //// edit
  getItem(int todoId) {
    editId = todoId;
    final currTodo = todoList.where((t) => t.id == todoId).last;
    txtName.text = currTodo.name!;
    txtGender.text = currTodo.gender!;
  }

  editTodo(TodoModel oldItem, TodoModel newItem) {
    final index = todoList.indexOf(oldItem);
    if (index != -1) {
      todoList[index] = newItem;
    }
  }

  // onRemove(TodoModel model) {
  //   todoList.removeWhere((e) => e.id == model.id);
  // }
  onRemove(TodoModel model) {
    todoList.remove(model);
  }

  //filter
  onfilter(String? text) {
    List<String> countries = [
      "Canada",
      "Brazil",
      "USA",
      "Japan",
      "China",
      "UK",
      "Uganda",
      "Uruguay"
    ];
    List<String> filter = [];
    filter.addAll(countries);
    filter.retainWhere((element) {
      return element.toLowerCase().contains('$text'.toLowerCase());
    });
    debugPrint('hello filter:$filter');
  }
}

class Counter {
  int value = 0;

  void increment() => value++;

  void decrement() => value--;
}

class ListManager {
  // List<String> itemList = [];
  List<Item> myList = [];

  // void addItemToList(String item) {
  //   itemList.add(item);
  // }
  void addItemToList(Item item) {
    myList.add(item);
  }
}

class Item {
  final String name;
  final int quantity;

  Item({required this.name, required this.quantity});
}
