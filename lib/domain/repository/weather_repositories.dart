import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/models/weather_model.dart';

import '../../data/network/failure.dart';

abstract class Repositories {
  Future<Either<Failure, WeatherModel>> getWetherByCityName(String cityName);
  Future<Either<Failure, List<WeatherModel>>> getForcastWeatherByCityName(
      String cityName);
}
