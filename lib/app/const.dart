import 'package:flutter/material.dart';

class Const {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/";
  static const String endPointWeather = "weather";
  static const String endPointForcast = "forecast";

  static const int timeOut = 60 * 100;
  static const String token = "b77f59adacf84c509602088458ea3834";
  static const String contentType = "application/json";
}

class ColorManager {
  static Color mainColor = const Color.fromRGBO(131, 169, 231, 1);
  static Color secColor = const Color.fromARGB(126, 95, 119, 153);

  static Color buttonColor = const Color.fromRGBO(79, 87, 98, 1);
}
