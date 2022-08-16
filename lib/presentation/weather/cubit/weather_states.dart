abstract class WeatherStates {}

class WeatherInitStates extends WeatherStates {}

class WeatherErrorStates extends WeatherStates {
  final String message;

  WeatherErrorStates(this.message);
}

class WeatherGetData extends WeatherStates {}

class WeatherOtherLocationsChanged extends WeatherStates {}
