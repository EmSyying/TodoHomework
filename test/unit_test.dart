import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/Modules/Todo/models/todo_model.dart';
// import 'package:get/get_connect/http/src/_http/mock/http_request_mock.dart';
// import 'package:http/http.dart';
// import 'package:mockito/mockito.dart';
import 'package:weather_app/Modules/controllers/weather_controller.dart';
import 'package:weather_app/Modules/models/weather_model.dart';
import 'package:weather_app/repository/repo.dart';
// import 'package:weather_app/repository/repo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Repo repo = Repo();
  group('String', () {
    // test('weather', () async {
    //   final con = WeatherController();
    //   final data = con.fetchWeather();

    //   expect(data, isA<Future<WeatherModel>>());
    // });
    // test('edit', () async {
    //   var todo = TodoController();
    //   var repo = Repo();
    //   var isEdit = true;
    //   var edit = todo.editTodo(1);
    //   // if (isEdit == true) {
    //   //   repo.addList(isEdit);
    //   // } else {
    //   //   isEdit = false;
    //   // }
    //   expect(edit, 1);
    // });
    // test('addlist', () {
    //   var model = TodoModel(id: 1, name: 'ying', gender: 'femail');
    //   var modified = TodoModel(id: 1, name: 'ying bee', gender: 'femail');
    //   repo.addList(true, model);

    //   expect(repo.todoList, contains(model));
    //   repo.editTodo(model, modified);
    //   expect(repo.todoList, contains(modified));
    // });
    test('list', () {
      int id = 1;
      var model = TodoModel(id: id, name: 'ying', gender: 'femail');
      repo.addList(false, model);
      expect(repo.todoList, contains(model));
      repo.onRemove(model);
      expect(repo.todoList, isNot(contains(model)));
    });
  });
}
