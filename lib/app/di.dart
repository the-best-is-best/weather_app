import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_app/domain/use_case/get_forcast_weather_by_country_name_use_case.dart';

import '../data/data_src/remote_data_src.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_manager.dart';
import '../data/network/network_info.dart';
import '../data/repository/weather_repositories_impl.dart';
import '../domain/repository/weather_repositories.dart';
import '../domain/use_case/get_weather_by_country_name_use_case.dart';

final di = GetIt.instance;

void initAppModel() {
  DioManger.init();
  di.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

// AppServicesClient
  di.registerLazySingleton<AppServicesClient>(
      () => AppServicesClient(DioManger.dioApi));
//
  di.registerLazySingleton<RemoteDataSrc>(() => RemoteDataSrcImpl(di()));
  //    repository

  di.registerLazySingleton<Repositories>(() => RepositoriesImpl(di(), di()));

  di.registerLazySingleton<GetWeatherByCountryNameUseCase>(
      () => GetWeatherByCountryNameUseCase(di()));
  di.registerLazySingleton<GetForcastWeatherByCountryNameUseCase>(
      () => GetForcastWeatherByCountryNameUseCase(di()));
  di.registerLazySingleton<GetStorage>(() => GetStorage());
}
