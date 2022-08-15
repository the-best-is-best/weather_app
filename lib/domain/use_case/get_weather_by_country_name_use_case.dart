import 'package:weather_app/data/network/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/models/weather_model.dart';
import 'package:weather_app/domain/repository/weather_repositories.dart';

import 'base_case.dart';

class GetWeatherByCountryNameUseCase extends BaseCase<String, WeatherModel> {
  final Repositories weatherRepository;

  GetWeatherByCountryNameUseCase(this.weatherRepository);
  @override
  Future<Either<Failure, WeatherModel>> execute(String input) async {
    return await weatherRepository.getWetherByCityName(input);
  }
}
