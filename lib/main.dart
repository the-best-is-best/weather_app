import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/app/di.dart';
import 'package:devicelocale/devicelocale.dart';
import 'app/app.dart';

bool? isDark;
String? language;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  initAppModel();
  await GetStorage.init();
  isDark = di<GetStorage>().read('isDark');
  language = di<GetStorage>().read('language');
  if (language == null) {
    language = await Devicelocale.currentLocale ?? 'en';
    debugPrint(language);
    language = language!.split('-')[0];
    di<GetStorage>().write('lang', language);
  } else {
    language = di<GetStorage>().read('lang');
  }
  runApp(Phoenix(child: const MyApp()));
}
