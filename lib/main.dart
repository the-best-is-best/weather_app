import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/di.dart';
import 'package:weather_app/presentation/weather/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/weather/view/weather_view.dart';

void main() async {
  initAppModel();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(di())..getData(),
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: Colors.blue[300],
            primarySwatch: Colors.teal,
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.blue[300],
                elevation: 0,
                systemOverlayStyle: Platform.isAndroid
                    ? SystemUiOverlayStyle(
                        statusBarColor: Colors.blue[300],
                        systemNavigationBarColor: Colors.blue[300],
                        statusBarIconBrightness: Brightness.light)
                    : null),
            brightness: Brightness.dark,
          ),
          home: const WeatherView()),
    );
  }
}
