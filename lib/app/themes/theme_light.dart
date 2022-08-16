import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const.dart';

ThemeData lightTheme() {
  return ThemeData(
    canvasColor: ColorManager.mainColor,
    primarySwatch: Colors.teal,
    appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.mainColor,
        elevation: 0,
        systemOverlayStyle: Platform.isAndroid
            ? SystemUiOverlayStyle(
                statusBarColor: Colors.blue[300],
                systemNavigationBarColor: Colors.blue[300],
                statusBarIconBrightness: Brightness.light)
            : null),
    brightness: Brightness.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: ColorManager.buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    ),
  );
}
