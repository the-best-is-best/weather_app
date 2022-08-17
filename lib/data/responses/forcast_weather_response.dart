import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/responses/weather_response.dart';
part 'forcast_weather_response.g.dart';

@JsonSerializable()
class ForcastWeatherResponse {
  @JsonKey(name: "list")
  List<WeatherResponse>? forcastWeather;

  ForcastWeatherResponse(this.forcastWeather);
  factory ForcastWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$ForcastWeatherResponseFromJson(json);
}
