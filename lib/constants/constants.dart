import 'package:flutter/material.dart';

class Constants {
  static const primaryColor = Color(0xff6b9dfc);
  static const secondaryColor = Color(0xffa1c6fd);
  static const tertiaryColor = Color(0xff205cf1);
  static const blackColor = Color(0xff1a1d26);

  static const greyColor = Color.fromARGB(255, 42, 110, 179);

  static Shader shader = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static const linearGradientBlue = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [
        Color.fromARGB(255, 104, 148, 229),
        Color.fromARGB(255, 100, 7, 146)
      ],
      stops: [
        0.0,
        1.0
      ]);

/*   final linearGradientPurple = const LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color.fromARGB(255, 11, 195, 8), Color.fromARGB(255, 230, 222, 5)],
      stops: [0.0, 1.0]); */
}
