class WeatherModel {
  final int id;
  final String cityName;
  final String status;
  final String description;
  final num temp;
  final num tempMin;
  final num tempMax;
  final num feelsLike;
  final num pressure;
  final num humidity;

  WeatherModel({
    required this.id,
    required this.cityName,
    required this.status,
    required this.description,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
  });
}

class Test {
  final String n;
  final String x;

  Test(this.n, this.x);
}
