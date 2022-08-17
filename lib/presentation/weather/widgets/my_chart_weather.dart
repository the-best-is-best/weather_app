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
            primaryXAxis: CategoryAxis(),
            series: <ChartSeries<WeatherModel, String>>[
              SplineSeries<WeatherModel, String>(
                  dataSource: weatherCubit.forcastWeatherModel!,
                  xValueMapper: (WeatherModel f, _) {
                    //  var r = f.dateTime.toString().split(' ')[0].split('-')[2];
                    //   var l = f.dateTime.toString().split(' ')[1].split(':')[0];
                    var r = DateFormat("dd").format(f.dateTime);
                    var l = DateFormat("HH").format(f.dateTime);
                    print("r: $r, l: $l");
                    var fandl = '$r-$l';
                    return fandl;
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
