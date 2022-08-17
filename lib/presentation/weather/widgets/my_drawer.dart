import 'package:buildcondition/buildcondition.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/app/extensions/extension_build_context.dart';
import 'package:weather_app/main.dart';
import '../../../app/components/my_field.dart';
import '../../../app/components/my_text.dart';
import '../../../app/di.dart';
import '../cubit/weather_cubit.dart';
import 'functions/select_country.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
    required this.weatherCubit,
  }) : super(key: key);

  final WeatherCubit weatherCubit;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final TextEditingController _favoriteCountryController =
      TextEditingController();
  final GetStorage _storage = di<GetStorage>();
  @override
  void initState() {
    if (_storage.read('favCountry') != null) {
      _favoriteCountryController.text = _storage.read('favCountry');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(20))),
        width: context.width * .9,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: const [
              //     SettingBottomSheet(),
              //   ],
              // ),
              child: ListTile(
                title: const MyText(text: 'Dark Theme'),
                leading: const Icon(Icons.brightness_high, size: 30),
                trailing: Switch(
                  value: isDark == null
                      ? SchedulerBinding.instance.window.platformBrightness ==
                              Brightness.dark
                          ? true
                          : false
                      : isDark == true
                          ? true
                          : false,
                  onChanged: (value) {
                    isDark = value;
                    di<GetStorage>().write('isDark', value);
                    Phoenix.rebirth(context);
                    context.back();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0) +
                  const EdgeInsets.symmetric(horizontal: 12),
              child: ListTileTheme(
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.star, size: 30),
                      trailing: Icon(Icons.error, size: 30),
                      title: MyText(text: 'Favorite Locations'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: MyField(
                            controller: _favoriteCountryController,
                            weatherCubit: widget.weatherCubit,
                            text: 'Enter City Name',
                            onTap: () {
                              context.showMyCountryPicker(
                                onSelect: (Country country) async {
                                  await _storage.write('favCountry',
                                      "${country.name},${country.countryCode}");
                                  widget.weatherCubit.getData(
                                      country:
                                          "${country.name},${country.countryCode}");
                                  if (!mounted) return;
                                  context.back();
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: IconButton(
                            icon: const Icon(
                              Icons.check_circle,
                              size: 30,
                            ),
                            onPressed: () {
                              widget.weatherCubit.getData();
                              context.back();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const ListTile(
                      leading: Icon(Icons.pin_drop_rounded, size: 30),
                      trailing: SizedBox(width: 30),
                      title: MyText(text: 'Other Locations'),
                    ),
                    BuildCondition(
                      condition:
                          widget.weatherCubit.otherLocations.isNotEmpty &&
                              widget.weatherCubit.selectedOtherLocation != null,
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            widget.weatherCubit.getDataByCountry(widget
                                    .weatherCubit.otherLocations[
                                widget.weatherCubit.selectedOtherLocation!]);
                            context.back();
                          },
                          child: MyText(
                              text: widget.weatherCubit.otherLocations[
                                  widget.weatherCubit.selectedOtherLocation!]),
                        );
                      },
                      fallback: (context) =>
                          const MyText(text: 'No other locations yet'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          context.back();
                          selectCountry(
                              context: context,
                              weatherCubit: widget.weatherCubit);
                        },
                        child: const MyText(text: 'Manage Locations')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
