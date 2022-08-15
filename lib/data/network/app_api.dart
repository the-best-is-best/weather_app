import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/app/const.dart';

import '../responses/weather_response.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Const.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String baseUrl}) =
      _AppServicesClient; // factory

  @GET(Const.endPointWeather)
  Future<WeatherResponse> getWeatherData({
    @Query('q') required String cityName,
    @Query("appid") String appId = Const.token,
  });
}
