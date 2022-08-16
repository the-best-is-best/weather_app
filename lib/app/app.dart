import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/const.dart';
import 'package:weather_app/app/di.dart';
import 'package:weather_app/app/extensions/extension_build_context.dart';
import 'package:weather_app/app/themes/theme_dark.dart';
import 'package:weather_app/app/themes/theme_light.dart';
import 'package:weather_app/presentation/weather/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/weather/view/weather_view.dart';
import '../main.dart';
import '../presentation/weather/cubit/weather_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
          onGenerateTitle: (BuildContext context) => context.strings().appTitle,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(language!),
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          themeMode: isDark == null
              ? ThemeMode.system
              : isDark == true
                  ? ThemeMode.dark
                  : ThemeMode.light,
          home: const WeatherView()),
    );
  }
}
