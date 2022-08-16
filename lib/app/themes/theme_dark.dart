import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const.dart';

ThemeData darkTheme() {
  return ThemeData(
    canvasColor: Colors.black,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        systemOverlayStyle: Platform.isAndroid
            ? const SystemUiOverlayStyle(
                statusBarColor: Colors.black45,
                systemNavigationBarColor: Colors.black45,
                statusBarIconBrightness: Brightness.dark)
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
