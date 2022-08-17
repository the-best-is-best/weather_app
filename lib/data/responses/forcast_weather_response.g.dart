// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forcast_weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForcastWeatherResponse _$ForcastWeatherResponseFromJson(
        Map<String, dynamic> json) =>
    ForcastWeatherResponse(
      (json['list'] as List<dynamic>?)
          ?.map((e) => WeatherResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForcastWeatherResponseToJson(
        ForcastWeatherResponse instance) =>
    <String, dynamic>{
      'list': instance.forcastWeather,
    };
