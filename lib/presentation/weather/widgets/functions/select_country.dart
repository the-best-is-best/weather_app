import 'package:buildcondition/buildcondition.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/extensions/extension_build_context.dart';
import '../../../../app/components/my_text.dart';
import '../../../../app/const.dart';
import '../../cubit/weather_cubit.dart';
import '../../cubit/weather_states.dart';

void selectCountry(
    {required BuildContext context, required WeatherCubit weatherCubit}) {
  Scaffold.of(context).showBottomSheet(
    (context) => Container(
      color: ColorManager.secColor,
      height: context.height * .6,
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                ],
              ),
              BlocBuilder<WeatherCubit, WeatherStates>(
                  builder: (context, states) {
                return BuildCondition(
                  condition: weatherCubit.otherLocations.isNotEmpty,
                  builder: (context) {
                    return SizedBox(
                      height: context.height * .45,
                      child: ListView.separated(
                        itemCount: weatherCubit.otherLocations.length,
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.black,
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            trailing: IconButton(
                              onPressed: () {
                                weatherCubit.removeOtherLocation(index);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 30,
                              ),
                            ),
                            title: MyText(
                                text: weatherCubit.otherLocations[index]),
                            onTap: () {
                              weatherCubit.changeSelectedOtherLocation(index);
                              context.back();
                            },
                          );
                        },
                      ),
                    );
                  },
                  fallback: (context) =>
                      const MyText(text: 'No other locations yet'),
                );
              }),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                context.showMyCountryPicker(onSelect: (Country value) {
                  weatherCubit
                      .addOtherLocation("${value.name}, ${value.countryCode}");
                });
              },
              child: const MyText(text: 'Add other locations'),
            ),
          ),
        ],
      ),
    ),
  );
}
