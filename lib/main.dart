import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/app/di.dart';
import 'package:weather_app/presentation/weather/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/weather/view/weather_view.dart';

import 'app/const.dart';

bool? isDark;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  initAppModel();
  await GetStorage.init();
  isDark = di<GetStorage>().read('isDark');

  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(di(), di())
        ..loadOtherLocations()
        ..getData(),
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
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: ColorManager.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ),
          darkTheme: ThemeData(
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ),
          themeMode: isDark == null
              ? ThemeMode.system
              : isDark == true
                  ? ThemeMode.dark
                  : ThemeMode.light,
          home: const WeatherView()),
    );
  }
}
