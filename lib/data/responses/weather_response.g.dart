// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      id: json['id'] as int?,
      cityName: json['name'] as String?,
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      main: json['main'] == null
          ? null
          : Main.fromJson(json['main'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.cityName,
      'weather': instance.weather,
      'main': instance.main,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      json['main'] as String?,
      json['description'] as String?,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'main': instance.status,
      'description': instance.description,
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      json['pressure'] as num?,
      json['temp'] as num?,
      json['feels_like'] as num?,
      json['humidity'] as num?,
      json['temp_min'] as num?,
      json['temp_max'] as num?,
    );

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'pressure': instance.pressure,
      'temp': instance.temp,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'feels_like': instance.feelsLike,
      'humidity': instance.humidity,
    };
