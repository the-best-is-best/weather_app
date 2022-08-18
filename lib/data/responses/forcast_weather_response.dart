import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/responses/weather_response.dart';
part 'forcast_weather_response.g.dart';

@JsonSerializable()
class ForcastWeatherResponse {
  final String? cod;
  @JsonKey(name: "list")
  final List<WeatherResponse>? forcastWeather;

  ForcastWeatherResponse(this.forcastWeather, this.cod);
  factory ForcastWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$ForcastWeatherResponseFromJson(json);
}
