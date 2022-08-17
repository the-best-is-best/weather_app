import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app/app/extensions/extension_num.dart';
import 'package:weather_app/domain/models/weather_model.dart';

import '../cubit/weather_cubit.dart';
import '../cubit/weather_states.dart';

class MyChartWeather extends StatelessWidget {
  const MyChartWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherStates>(builder: (context, states) {
      WeatherCubit weatherCubit = WeatherCubit.get(context);

      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 240,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SfCartesianChart(
            zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
            primaryXAxis: CategoryAxis(interval: 1),
            series: <ChartSeries<WeatherModel, String>>[
              SplineSeries<WeatherModel, String>(
                  dataSource: weatherCubit.forcastWeatherModel!,
                  xValueMapper: (WeatherModel f, _) {
                    var day = DateFormat("dd").format(f.dateTime);
                    var hour = DateFormat("HH").format(f.dateTime);
                    var time = '$day-$hour';
                    return time;
                  },
                  yValueMapper: (WeatherModel f, _) =>
                      f.temp.kelvinToCelsius()),
            ],
          ),
        ),
      );
    });
  }
}
