import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/app/di.dart';
import 'package:weather_app/presentation/weather/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/weather/view/weather_view.dart';

import 'app/const.dart';

void main() async {
  initAppModel();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(di(), di())..getData(),
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
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
          ),
          home: const WeatherView()),
    );
  }
}
