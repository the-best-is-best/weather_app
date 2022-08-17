import 'package:weather_app/app/extensions.dart';

import '../../domain/models/weather_model.dart';
import '../responses/forcast_weather_response.dart';
import '../responses/weather_response.dart';

extension HomeResponseMapper on ForcastWeatherResponse? {
  List<WeatherModel> toDomain() {
    return <WeatherModel>[
      for (WeatherResponse item
          in this?.forcastWeather ?? [].cast<WeatherResponse>())
        WeatherModel(
            id: item.id.orEmpty(),
            cityName: item.cityName.orEmpty(),
            description: item.weather?[0].description?.orEmpty() ?? "",
            pressure: item.main?.pressure?.orEmpty() ?? 0,
            status: item.weather?[0].status?.orEmpty() ?? "",
            feelsLike: item.main?.feelsLike?.orEmpty() ?? 0,
            temp: item.main?.temp.orEmpty().round() ?? 0,
            tempMin: item.main?.feelsLike?.orEmpty() ?? 0,
            tempMax: item.main?.feelsLike?.orEmpty() ?? 0,
            humidity: item.main?.humidity.orEmpty() ?? 0,
            speed: item.wind?.speed.orEmpty() ?? 0,
            deg: item.wind?.deg.orEmpty() ?? 0,
            dateTime: item.dateTime ?? DateTime.now())
    ];
  }
}
