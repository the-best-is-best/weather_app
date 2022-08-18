import 'package:json_annotation/json_annotation.dart';
part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final int? cod;
  final int? id;
  @JsonKey(name: "name")
  final String? cityName;
  final List<Weather>? weather;
  final Wind? wind;
  final Main? main;
  @JsonKey(name: "dt")
  final int dateTime;
  @JsonKey(name: "sys")
  final SunriseOrSunset? sunriseOrSunset;
  WeatherResponse({
    this.id,
    this.cityName,
    this.weather,
    this.main,
    this.wind,
    required this.dateTime,
    this.cod,
    this.sunriseOrSunset,
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

@JsonSerializable()
class SunriseOrSunset {
  final int? sunrise;
  final int? sunset;

  SunriseOrSunset(this.sunrise, this.sunset);
  factory SunriseOrSunset.fromJson(Map<String, dynamic> json) {
    return _$SunriseOrSunsetFromJson(json);
  }
}
