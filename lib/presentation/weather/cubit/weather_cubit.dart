import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/models/weather_model.dart';
import 'package:weather_app/presentation/weather/cubit/weather_states.dart';
import '../../../domain/use_case/get_weather_by_country_name_use_case.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit(this.useCase) : super(WeatherInitStates());
  static WeatherCubit get(BuildContext context) =>
      BlocProvider.of<WeatherCubit>(context);

  final GetWeatherByCountryNameUseCase useCase;
  WeatherModel? weatherModel;

  void getData({String country = "Egypt"}) async {
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
