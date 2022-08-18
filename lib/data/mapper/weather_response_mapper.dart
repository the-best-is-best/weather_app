import 'package:weather_app/app/extensions.dart';
import 'package:weather_app/app/extensions/extenstion_int.dart';

import '../../domain/models/weather_model.dart';
import '../responses/weather_response.dart';

extension HomeResponseMapper on WeatherResponse? {
  WeatherModel toDomain() {
    return WeatherModel(
      id: this?.id?.orEmpty() ?? 0,
      cityName: this?.cityName?.orEmpty() ?? "",
      description: this?.weather?[0].description?.orEmpty() ?? "",
      pressure: this?.main?.pressure?.orEmpty() ?? 0,
      status: this?.weather?[0].status?.orEmpty() ?? "",
      feelsLike: this?.main?.feelsLike?.orEmpty() ?? 0,
      temp: this?.main?.temp.orEmpty() ?? 0,
      tempMin: this?.main?.feelsLike?.orEmpty() ?? 0,
      tempMax: this?.main?.feelsLike?.orEmpty() ?? 0,
      humidity: this?.main?.humidity.orEmpty() ?? 0,
      speed: this?.wind?.speed.orEmpty() ?? 0,
      deg: this?.wind?.deg.orEmpty() ?? 0,
      dateTime: this?.dateTime.toDateTime(),
      sunrise: this?.sunriseOrSunset?.sunrise.orEmpty().toDateTime(),
      sunset: this?.sunriseOrSunset?.sunset.orEmpty().toDateTime(),
    );
  }
}
