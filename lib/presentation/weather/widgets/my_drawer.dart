import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/app/extensions/extension_build_context.dart';

import '../../../app/components/my_field.dart';
import '../../../app/components/my_text.dart';
import '../../../app/di.dart';
import '../cubit/weather_cubit.dart';

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
        width: context.width * .9,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.star, size: 30),
                trailing: Icon(Icons.error, size: 30),
                title: MyText(text: 'Favorite Locations'),
              ),
              const SizedBox(height: 10),
              MyField(
                controller: _favoriteCountryController,
                weatherCubit: widget.weatherCubit,
                text: 'Enter City Name',
                onTap: () {
                  context.showMyCountryPicker(
                    onSelect: (Country country) async {
                      await _storage.write('favCountry',
                          "${country.name},${country.countryCode}");
                      widget.weatherCubit.getData(
                          country: "${country.name},${country.countryCode}");

                      context.back();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
