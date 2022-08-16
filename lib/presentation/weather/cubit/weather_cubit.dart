import 'dart:convert';

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

  List<String> otherLocations = [];
  int? selectedOtherLocation;

  void loadOtherLocations() {
    try {
      if (box.read<String>('otherLocations') != null) {
        List<dynamic> dataFromJson =
            json.decode(box.read<String>('otherLocations')!);
        for (var element in dataFromJson) {
          otherLocations.add(element);
        }
      }
      selectedOtherLocation = box.read('selectedOtherLocation');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future _saveOtherLocations() async {
    await box.write('otherLocations', json.encode(otherLocations));
  }

  void changeSelectedOtherLocation(int index) {
    selectedOtherLocation = index;
    box.write('selectedOtherLocation', selectedOtherLocation);
    emit(WeatherOtherLocationsChanged());
  }

  void addOtherLocation(String country) async {
    if (otherLocations.contains(country)) {
      return;
    }
    otherLocations.add(country);
    await _saveOtherLocations();
    selectedOtherLocation = otherLocations.length - 1;
    emit(WeatherOtherLocationsChanged());
  }

  void removeOtherLocation(int index) {
    otherLocations.removeAt(index);
    _saveOtherLocations();
    if (selectedOtherLocation == index) {
      selectedOtherLocation = null;
      box.write('selectedOtherLocation', selectedOtherLocation);
    } else if (selectedOtherLocation != null &&
        index < selectedOtherLocation!) {
      selectedOtherLocation = selectedOtherLocation! - 1;
    }
    emit(WeatherOtherLocationsChanged());
  }

  void getData({String country = "Egypt,eg"}) async {
    weatherModel = null;
    emit(WeatherInitStates());
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

  void getDataByCountry(String country) async {
    weatherModel = null;
    emit(WeatherInitStates());

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
