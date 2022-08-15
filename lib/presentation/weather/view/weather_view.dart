import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/app/extensions/extension_double.dart';
import 'package:weather_app/presentation/weather/cubit/weather_cubit.dart';

import '../../../app/components/my_loading.dart';
import '../../../gen/assets.gen.dart';
import '../../../app/components/my_text.dart';
import '../cubit/weather_states.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherCubit weatherCubit = WeatherCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<WeatherCubit, WeatherStates>(
          listener: (context, state) => true,
          builder: (context, state) {
            return BuildCondition(
                condition: state is! WeatherInitStates,
                fallback: (context) => const MyLoading(),
                builder: (context) {
                  return BuildCondition(
                    condition: state is! WeatherErrorStates,
                    fallback: (context) => Center(
                      child:
                          MyText(text: (state as WeatherErrorStates).message),
                    ),
                    builder: (context) {
                      return CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            leading: const SizedBox.shrink(),
                            snap: true,
                            pinned: true,
                            floating: true,
                            expandedHeight: 200.0,
                            flexibleSpace: FlexibleSpaceBar(
                              title: MyText(
                                  text: weatherCubit.weatherModel!.cityName),
                              background: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MyText(
                                        text: weatherCubit.weatherModel!.temp
                                            .kelvinToCelsius(),
                                        style: const TextStyle(fontSize: 50),
                                      ),
                                      Lottie.asset(const $AssetsJsonGen().moon,
                                          width: 150),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 50),
                                  MyText(
                                    text: weatherCubit.weatherModel!.tempMin
                                            .kelvinToCelsius() +
                                        " / ${weatherCubit.weatherModel!.tempMax.kelvinToCelsius()}" +
                                        " Feels like ${weatherCubit.weatherModel!.feelsLike.kelvinToCelsius()}",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
