import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/app/extensions/extension_NUM.dart';
import 'package:weather_app/app/extensions/extension_build_context.dart';
import 'package:weather_app/app/extensions/extension_date.dart';
import 'package:weather_icons/weather_icons.dart';

import '../../../app/components/my_text.dart';
import '../../../app/const.dart';
import '../../../main.dart';
import '../cubit/weather_cubit.dart';

class BuildWeather extends StatelessWidget {
  const BuildWeather({
    Key? key,
    required this.weatherCubit,
  }) : super(key: key);

  final WeatherCubit weatherCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: weatherCubit.weatherModel!.tempMin.kelvinToCelsiusString() +
              " / ${weatherCubit.weatherModel!.tempMax.kelvinToCelsiusString()}" +
              " ${context.strings().feels_like} ${weatherCubit.weatherModel!.feelsLike.kelvinToCelsiusString()}",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: isDark == true ? Colors.white : null),
        ),
        const SizedBox(height: 10),
        MyText(
          text: weatherCubit.weatherModel!.dateTime!
                  .isSunsetOrSunrise(weatherCubit.weatherModel!.sunset!)
              ? "Sun ${weatherCubit.weatherModel!.dateTime!.toTime()}"
              : "Moon ${weatherCubit.weatherModel!.dateTime!.toTime()}",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: isDark == true ? Colors.white : null),
        ),
        const SizedBox(height: 10),
        MyText(
          text: weatherCubit.weatherModel!.description,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: isDark == true ? Colors.white : null),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 50,
          child: Card(
            color: ColorManager.mainColor.withOpacity(.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(WeatherIcons.humidity, size: 15),
                    const SizedBox(width: 5),
                    MyText(
                      text: '${weatherCubit.weatherModel!.humidity} %',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(width: 15),
                    Row(
                      children: [
                        const Icon(WeatherIcons.wind, size: 15),
                        const SizedBox(width: 5),
                        MyText(
                          text: '${weatherCubit.weatherModel!.speed} m/s',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.boltLightning, size: 15),
                        const SizedBox(width: 5),
                        MyText(
                          text: '${weatherCubit.weatherModel!.pressure} hPa',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyText(
                text: 'forcast next 5 days'.toUpperCase(),
              ),
              const Icon(
                Icons.next_plan_outlined,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
