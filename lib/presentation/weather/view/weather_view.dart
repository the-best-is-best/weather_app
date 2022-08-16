import 'package:buildcondition/buildcondition.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/app/const.dart';
import 'package:weather_app/app/extensions/extension_build_context.dart';
import 'package:weather_app/app/extensions/extension_num.dart';
import 'package:weather_app/app/extensions/extension_date.dart';
import 'package:weather_app/presentation/weather/cubit/weather_cubit.dart';
import 'package:weather_icons/weather_icons.dart';
import '../../../app/components/my_field.dart';
import '../../../app/components/my_loading.dart';
import '../../../app/components/my_text.dart';
import '../../../main.dart';
import '../cubit/weather_states.dart';
import '../widgets/my_drawer.dart';
import '../widgets/my_sliver_app_bar.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherCubit weatherCubit = WeatherCubit.get(context);
    return Scaffold(
      drawer: MyDrawer(weatherCubit: weatherCubit),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(text: (state as WeatherErrorStates).message),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => weatherCubit.getData(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                    builder: (context) {
                      return CustomScrollView(
                        slivers: [
                          MySliverAppBar(weatherCubit: weatherCubit),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 12, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 50),
                                  MyText(
                                    text: weatherCubit.weatherModel!.tempMin
                                            .kelvinToCelsius() +
                                        " / ${weatherCubit.weatherModel!.tempMax.kelvinToCelsius()}" +
                                        " Feels like ${weatherCubit.weatherModel!.feelsLike.kelvinToCelsius()}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: isDark == true
                                            ? Colors.white
                                            : null),
                                  ),
                                  const SizedBox(height: 10),
                                  MyText(
                                    text: DateTime.now().isSunsetOrSunrise()
                                        ? "Sun ${DateTime.now().toTime()}"
                                        : "Moon ${DateTime.now().toTime()}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: isDark == true
                                            ? Colors.white
                                            : null),
                                  ),
                                  const SizedBox(height: 10),
                                  MyText(
                                    text:
                                        weatherCubit.weatherModel!.description,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: isDark == true
                                            ? Colors.white
                                            : null),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 50,
                                    child: Card(
                                      color: ColorManager.mainColor
                                          .withOpacity(.5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(WeatherIcons.humidity,
                                                  size: 15),
                                              const SizedBox(width: 5),
                                              MyText(
                                                text:
                                                    '${weatherCubit.weatherModel!.humidity} %',
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              const SizedBox(width: 15),
                                              Row(
                                                children: [
                                                  const Icon(WeatherIcons.wind,
                                                      size: 15),
                                                  const SizedBox(width: 5),
                                                  MyText(
                                                    text:
                                                        '${weatherCubit.weatherModel!.speed} m/s',
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 15),
                                              Row(
                                                children: [
                                                  const FaIcon(
                                                      FontAwesomeIcons
                                                          .boltLightning,
                                                      size: 15),
                                                  const SizedBox(width: 5),
                                                  MyText(
                                                    text:
                                                        '${weatherCubit.weatherModel!.pressure} hPa',
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
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
