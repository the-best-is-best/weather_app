import 'package:weather_app/data/network/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/models/weather_model.dart';
import 'package:weather_app/domain/repository/weather_repositories.dart';

import 'base_case.dart';

class GetForcastWeatherByCountryNameUseCase
    extends BaseCase<String, List<WeatherModel>> {
  final Repositories weatherRepository;

  GetForcastWeatherByCountryNameUseCase(this.weatherRepository);
  @override
  Future<Either<Failure, List<WeatherModel>>> execute(String input) async {
    return await weatherRepository.getForcastWeatherByCityName(input);
  }
}
