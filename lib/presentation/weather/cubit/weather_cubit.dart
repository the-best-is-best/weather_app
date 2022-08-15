import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/domain/models/weather_model.dart';
import 'package:weather_app/presentation/weather/cubit/weather_states.dart';
import '../../../domain/use_case/get_weather_by_country_name_use_case.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit(this.useCase, this.box) : super(WeatherInitStates());
  static WeatherCubit get(BuildContext context) =>
      BlocProvider.of<WeatherCubit>(context);

  final GetWeatherByCountryNameUseCase useCase;
  WeatherModel? weatherModel;
  GetStorage box;
  void getData({String country = "Egypt,eg"}) async {
    weatherModel = null;
    String? favCountry = box.read('favCountry');
    var data = await useCase.execute(favCountry ?? country);
    data.fold(
      (error) {
        emit(WeatherErrorStates(error.messages));
      },
      (data) {
        weatherModel = data;
        emit(WeatherGetData());
      },
    );
  }

  void searchWeather(String country) async {
    weatherModel = null;
    var data = await useCase.execute(country);
    data.fold(
      (error) {
        emit(WeatherErrorStates(error.messages));
      },
      (data) {
        weatherModel = data;
        emit(WeatherGetData());
      },
    );
  }
}
