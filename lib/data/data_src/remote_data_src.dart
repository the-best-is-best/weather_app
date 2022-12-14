import 'package:weather_app/data/responses/weather_response.dart';

import '../network/app_api.dart';
import '../responses/forcast_weather_response.dart';

abstract class RemoteDataSrc {
  Future<WeatherResponse> getWeatherByCityName(String cityName);
  Future<ForcastWeatherResponse> getFiveDaysThreeHoursForcastData(
      String cityName);
}

class RemoteDataSrcImpl extends RemoteDataSrc {
  final AppServicesClient _appServicesClient;

  RemoteDataSrcImpl(this._appServicesClient);

  @override
  Future<WeatherResponse> getWeatherByCityName(String cityName) async {
    return _appServicesClient.getWeatherData(cityName: cityName);
  }

  @override
  Future<ForcastWeatherResponse> getFiveDaysThreeHoursForcastData(
      String cityName) async {
    return _appServicesClient.getFiveDaysThreeHoursForcastData(
        cityName: cityName);
  }
}
