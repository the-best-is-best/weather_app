import 'package:json_annotation/json_annotation.dart';
part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final int? id;
  @JsonKey(name: "name")
  final String? cityName;
  final List<Weather>? weather;
  final Wind? wind;
  final Main? main;
  WeatherResponse(
    this.wind, {
    this.id,
    this.cityName,
    this.weather,
    this.main,
  });
  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}

@JsonSerializable()
class Weather {
  @JsonKey(name: "main")
  final String? status;
  final String? description;

  Weather(this.status, this.description);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return _$WeatherFromJson(json);
  }
}

@JsonSerializable()
class Wind {
  final num? speed;
  final num? deg;
  Wind({this.speed, this.deg});
  factory Wind.fromJson(Map<String, dynamic> json) {
    return _$WindFromJson(json);
  }
}

@JsonSerializable()
class Main {
  final num? pressure;
  final num? temp;
  @JsonKey(name: "temp_min")
  final num? tempMin;
  @JsonKey(name: "temp_max")
  final num? tempMax;
  @JsonKey(name: "feels_like")
  final num? feelsLike;
  final num? humidity;

  Main(this.pressure, this.temp, this.feelsLike, this.humidity, this.tempMin,
      this.tempMax);
  factory Main.fromJson(Map<String, dynamic> json) {
    return _$MainFromJson(json);
  }
}
