import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/extensions/extension_build_context.dart';
import 'package:weather_app/presentation/weather/cubit/weather_cubit.dart';
import '../../../app/components/my_loading.dart';
import '../../../app/components/my_text.dart';
import '../cubit/weather_states.dart';
import '../widgets/build_weather.dart';
import '../widgets/my_chart_weather.dart';
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
                            child: MyText(
                              text: context.strings().try_again_later,
                            ),
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
                                children: [
                                  const SizedBox(height: 50),
                                  BuildWeather(weatherCubit: weatherCubit),
                                  const SizedBox(height: 10),
                                  const MyChartWeather(),
                                  const SizedBox(height: 50),
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
