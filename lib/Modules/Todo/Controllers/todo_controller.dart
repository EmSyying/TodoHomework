// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../models/todo_model.dart';

// class TodoController extends GetxController {
//   final todoModel = TodoModel().obs;
// // List<TodoModel>addMore = todoList.reversed.toList();
//   final id = 1.obs;

//   final todoList = <TodoModel>[
//     // TodoModel(
//     //     name: 'Sok kun',
//     //     // age: '28',
//     //     // phoneNumber: '0233444451',
//     //     gender: 'Male'),
//     // TodoModel(
//     //     name: 'Dara',
//     //     // age: '19',
//     //     // phoneNumber: '012334444',
//     //     gender: 'Male'),
//     // TodoModel(
//     //     name: 'sitha',
//     //     // age: '31',
//     //     // phoneNumber: '089744262',
//     //     gender: 'Male'),
//   ].obs;
//   String? myname = '';
//   final TextEditingController txtName = TextEditingController();
//   final TextEditingController txtGender = TextEditingController();

//   final isValidateName = false.obs;
//   final isValidateGender = false.obs;

//   String? get validName {
//     final text = txtName.text;
//     if (text.isEmpty) {
//       return 'Please input text';
//     }
//     // if (text.length < 4) {
//     //   return 'Too short';
//     // }
//     // return null if the text is valid
//     return null;
//   }

//   String? get validGender {
//     final text = txtGender.text;
//     if (text.isEmpty) {
//       return 'Please input text';
//     }

//     return null;
//   }

//   final editId = 0.obs;
//   editTodo(int todoId) {
//     editId.value = todoId;
//     final currTodo = todoList.where((t) => t.id == todoId).last;
//     txtName.text = currTodo.name!;
//     txtGender.text = currTodo.gender!;
//   }

//   onfilter(String? text) {
//     List<String> countries = [
//       "Canada",
//       "Brazil",
//       "USA",
//       "Japan",
//       "China",
//       "UK",
//       "Uganda",
//       "Uruguay"
//     ];
//     List<String> filter = [];
//     filter.addAll(countries);
//     filter.retainWhere((element) {
//       return element.toLowerCase().contains('$text'.toLowerCase());
//     });
//     debugPrint('hello filter:$filter');
//   }
// }
