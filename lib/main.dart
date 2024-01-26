import 'package:flutter/material.dart';
import 'package:weather_app/Modules/Todo/Screens/todo_screen.dart';
import 'package:weather_app/Modules/screens/home_page.dart';
import 'package:weather_app/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TodoScreen(),
      theme: themes(),
    );
  }
}
