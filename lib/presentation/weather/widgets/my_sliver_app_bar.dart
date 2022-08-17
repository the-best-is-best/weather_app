import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/app/extensions/extension_build_context.dart';
import 'package:weather_app/app/extensions/extension_num.dart';
import 'package:weather_app/app/extensions/extension_date.dart';

import '../../../app/components/my_field.dart';
import '../../../app/components/my_text.dart';
import '../../../gen/assets.gen.dart';
import '../cubit/weather_cubit.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    Key? key,
    required this.weatherCubit,
  }) : super(key: key);

  final WeatherCubit weatherCubit;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: true,
      pinned: true,
      floating: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 30),
        title: MyText(text: weatherCubit.weatherModel!.cityName),
        background: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyText(
                    text:
                        weatherCubit.weatherModel!.temp.kelvinToCelsiusString(),
                    style: const TextStyle(fontSize: 50),
                  ),
                  Lottie.asset(
                      DateTime.now().isSunsetOrSunrise()
                          ? const $AssetsJsonGen().sun
                          : const $AssetsJsonGen().moon,
                      width: 150),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: context.width * .5,
            height: context.height * .1,
            child: MyField(
              weatherCubit: weatherCubit,
              text: 'Enter City Name',
              onSubmitted: ((value) {
                if (value.isNotEmpty) {
                  weatherCubit.getDataByCountry(value);
                }
              }),
            ),
          ),
        ),
      ],
    );
  }
}
